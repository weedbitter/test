#!/usr/bin/perl
use DBI;
use Data::Dump;

my $dsn = "dbi:DB2:zdb";
my $user = "db2inst";
my $pass = "db2inst";

my $dbh = DBI->connect(
   $dsn, 
   $user, 
   $pass,
   { RaiseError => 1, AutoCommit => 0 },
);


# insert
my $sql = q/insert into T(a, b) values(?, ?)/;
my $sth = $dbh->prepare($sql);
$sth->execute(1,1);
$sth->execute(2,2);
$sth->execute(3,3);
$sth->execute(4,4);
$dbh->commit();
$sth->finish();

# retrieval
$sql = q/select a, b from T/;
$sth = $dbh->prepare($sql);
$sth->execute();
while(my $row = $sth->fetchrow_hashref()) {
    warn "I got row:\n" . Data::Dump->dump($row);
}
$sth->finish();

# delte
$sql = q/delete from T where a = ?/;
$sth = $dbh->prepare($sql);
$sth->execute(1);
$sth->execute(2);
$dbh->commit();
$sth->finish();

# update
$sql = q/update T set a = a * ? where b = ?/;
$sth = $dbh->prepare($sql);
$sth->execute(2, 3);
$dbh->commit();

$dbh->disconnect();
