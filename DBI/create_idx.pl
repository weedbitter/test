#!/usr/bin/perl
use DBI;
use Data::Dump;
use strict;
use Time::Elapse;
use Getopt::Long;


my $type;
my $flag;
my $rtn = GetOptions(
    "type|t=s" => \$type,
) or &usage;

unless ($type) {
   &usage;
}



my $dsn = "dbi:DB2:zdb_dev";
my $user = "db2inst";
my $pass = 'db2inst';

my $dbh = &dbh;

#记录日志
my $log = IO::File->new( ">>create_idx.log" )  or die "can't open create_idx.log ";
#记录所有表明
my @tables ;


#时间戳
Time::Elapse->lapse(my $time = "Time of create all_idx");

&get_tables;
#Data::Dump->dump(\@tables);

if ( $type =~ /^create_idx$/ ) {
    print "create idx [start]...\n";
    &create_idx;
}
elsif ( $type =~ /^drop_idx$/ ) {
    print "drop idx [start]...\n";
    &drop_idx;
}
else {
    &usage;
}

$dbh->disconnect();
print $time . "\n";




# create unique index idx_$book on $book (zjdz_date, type, b_acct);
# print "create unique index idx_job_dz_0 on job_dz (zjdz_date, type, b_acct);book_" . $row->{value} . "\n";

sub create_idx {
    unless (defined @tables[0]) {
        print "没有要创建的表，程序退出。\n";
        return 1;
    }
    for (@tables) {
        Time::Elapse->lapse(my $mytime = "Time of create idx of $_ on period");
        print "[start] create idx of $_ on period...\n";
        my $sql =  "create index idx_" . $_ . "_period on " . $_ . "(period)" ;
        print ">>>>>> using sql is : [$sql] \n";
        
        eval {
            my $sth = $dbh->do($sql);
        };
        if($@){
            print ("[error]-> [$@] \n");
            $dbh->rollback();
            exit 0;
        }
        print "[end] create idx of $_ on period >>> ：" . $mytime . "\n";
    }
    $dbh->commit();
}

sub drop_idx {
    unless (defined @tables[0]) {
        print "没有要删除的表，程序退出。\n";
        return 1;
    }
    for (@tables) {
        Time::Elapse->lapse(my $mytime = "Time of drop idx of $_ on period");
        print "[start] drop idx of $_ on period...\n";
        my $sql =  "drop index idx_" . $_  . "_period";
        print ">>>>>> using sql is : [$sql] \n";
        
        eval {
            my $sth = $dbh->do($sql);
        };
        if($@){
            print ("[warn]-> [$@] \n");
        }
        print "[end] drop idx of $_ on period >>> ：" . $mytime . "\n";
    }
    $dbh->commit();
}

sub get_tables {
    my $book_sql = q/select value from dict_book/;
    my $sth_book = $dbh->prepare($book_sql);
    $sth_book->execute();
    while(my $row = $sth_book->fetchrow_hashref()) {
        push @tables ,"book_" . $row->{value} ;
    }
    $sth_book->finish();

    my $yspz_sql = q/select code from dict_yspz/;
    my $sth_yspz = $dbh->prepare($yspz_sql);
    $sth_yspz->execute();
    while(my $row = $sth_yspz->fetchrow_hashref()) {
        push @tables , "yspz_" .$row->{code} ;
    }
    $sth_yspz->finish();
}


sub dbh {
    my $dbh       = DBI->connect(
        $dsn, 
        $user, 
        $pass,
        {
            RaiseError          => 1,
            PrintError          => 0,
            AutoCommit          => 0,
            FetchHashKeyName    => 'NAME_lc',
            ChopBlanks          => 1,
            InactiveDestroy     => 1,
        }
    );
    unless ($dbh) {
        print "can not connect db \n";
    }

    return $dbh;
}


# help & prompt
sub usage {
    print <<EOF;
        create_idx.pl -t create_idx >>>:创建所有book和yspz的索引，on period
        create_idx.pl -t drop_idx   >>>:删除所有book和yspz的索引，on period
EOF
    exit 1;
}
