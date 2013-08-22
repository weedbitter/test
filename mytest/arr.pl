#!usr/bin/perl
use strict;
use Data::Dump;

my @arr1;
my @arr2;
my $i = 1;
while($i < 10){
    my $arr = $_;
    push @arr1,$arr;
    push @arr2,$i;
    $i ++;
}
Data::Dump->dump(@arr1);
Data::Dump->dump(@arr2);
