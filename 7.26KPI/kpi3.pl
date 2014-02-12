#!/usr/bin/perl
use DBI;
use Data::Dump;

my $dsn  = "dbi:DB2:zdb_dev";
my $user = "db2inst";
my $pass = "db2inst";

my $dbh = DBI->connect(
   $dsn, 
   $user, 
   $pass,
   { RaiseError => 1, AutoCommit => 0 },
);


my $sql = q/insert into tbl_cfg_inf(pid, ppid, name) values(?, ?, ?)/;
my $sth = $dbh->prepare($sql);

open $read_ps, "ps -ef | awk '{ print \$2 \"  \" \$3 \"  \" \$8 }'  |";     # 管道读取 
my $head = <$read_ps>;   # 读取表头  PID  PPID  CMD 丢弃;

my $cnt = 0;
while(<$read_ps>) {
      my ($pid, $ppid, $name) = (split);
#      warn sprintf("%-10d  | %-10d | %s\n", $pid, $ppid, $name);
     # 插入…
      $sth->execute($pid,$ppid,$name);
      if (++$cnt == 50) {
          $dbh->commit();
          $cnt = 0;
      }
}
if ($cnt) {
    $dbh->commit();
}
$sth->finish();
close $read_ps;

## retrieval
#$sql = q/select * from tbl_cfg_inf/;
#$sth = $dbh->prepare($sql);
#$sth->execute();
#
#my $children = [
#    {
#       pid => 0,
#       name => 'root',
#       children => "children"
#    }, 
#    {
#       pid => 0,
#       name => 'root',
#       children => "children"
#    }, 
#    {
#       pid => 0,
#       name => 'root',
#       children => "children"
#    } 
#
#];
#my $proc = {
#   pid => 0,
#   name => 'root',
#   children => $children
#};
#my @tmp;
#my %htmp;
#while(my $row = $sth->fetchrow_hashref()) {
##   warn "I got row:\n" . Data::Dump->dump($row);
#    unshift(@tmp,$row);
#}
#
#
#Data::Dump->dump(@tmp);
#Data::Dump->dump($proc);
#&findfather (@tmp);
#Data::Dump->dump($proc);
#$dbh->commit();
#$sth->finish();
#
#
#$dbh->disconnect();
#
#sub findfather{
#    my $cproc = shift;
#    if ( $cproc->{ppid} == 0){
#        my %hash = {
#                 name => $cproc->{name},
#                 pid   => $cproc->{pid},
#                 children => ""
#        }
##        unshift (@$proc->{children},\%hash);
#    }
#    Data::Dump->dump(@$cproc);
#}
