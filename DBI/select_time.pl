#!/usr/bin/perl
use DBI;
use Data::Dump;
use Time::Elapse;


my $dsn = "dbi:DB2:zdb_dev";
my $user = "db2inst";
my $pass = 'db2inst';

my $dbh = &dbh;



# retrieval

warn "start:\n";

Time::Elapse->lapse(my $time = "db2select");
$sql = q/select * from yspz_0055 where period = '2013-12-10'/;
$sth = $dbh->prepare($sql);
$sth->execute();
while(my $row = $sth->fetchrow_hashref()) {
    
}

$sth->finish();
#$sth->commit();

#$dbh->disconnect();
print $time . "\n";


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
         warn "can not connect db";
    }

    return $dbh;
}

