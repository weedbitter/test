#!/usr/bin/perl

use DBI;
use Env qw/MEM_HOME/;
use Encode qw/decode/;
use Cache::Memcached;
use JSON;
use Zmem;
use Data::Dump;

my $cfg = do "$MEM_HOME/conf/conf.pl";
$cfg->{dbh} = &connect_db($cfg);
$cfg->{memd}  = new Cache::Memcached {
    'servers'            => $cfg->{mem_server},
    'debug'              => 0,
    'compress_threshold' => 10_000,
};
my $Zmem = Zmem->new($cfg);
$cfg->{Zmem} = $Zmem;
$Zmem->init_memd();

#Data::Dump->dump($Zmem->get_table('dim_fch'));
#my $ins  = $Zmem->insert('dim_fch','ccc001','ccc','1','ccc');
#Data::Dump->dump($Zmem->get_table('dim_fch'));
#my $ins  = $Zmem->insert('dim_fch','ddd002','ddd','1','ddd');
#Data::Dump->dump($Zmem->get_table('dim_fch'));
#my $ins  = $Zmem->insert('dim_fch','ccc003','ccc','1','ccc');
#Data::Dump->dump($Zmem->get_table('dim_fch'));
#
#for my $i (1..100){
#    my $ins  = $Zmem->insert('dim_fch',"test$i",'ddd','1','ddd');
#    Data::Dump->dump($Zmem->get_table('dim_fch'));
#    sleep(2);
#}
#my $res = JSON->new->utf8->encode(['json values']);
#$cfg->{memd}->set('json' , $res);
#my $s = JSON->new->utf8->decode($Zmem->get_table('json') );
Data::Dump->dump($Zmem->get_table('dept_matcher'));
#Data::Dump->dump( $s);

#my $arr = ['1','2','3'];
#$cfg->{memd}->set('array' , $arr);
#Data::Dump->dump($Zmem->get_table('array'));

#print "$ins\n";

$cfg->{dbh}->disconnect();





###################
#方法
###################



sub connect_db {
    my $cfg = shift;
    my $dbh;
    $dbh = DBI->connect(
        $cfg->{dsn},
        $cfg->{user},
        $cfg->{pass},
        {
            RaiseError       => 1,
            PrintError       => 0,
            AutoCommit       => 0,
            FetchHashKeyName => 'NAME_lc',
            ChopBlanks       => 1,
        }
    );
    unless ($dbh) {
        warn ("can not connect $cfg->{dsn}");
        return;
    }

    $dbh->do("set current schema $cfg->{schema}")
        or warn ("can not set current schema $cfg->{schema}");

    return $dbh;
}

