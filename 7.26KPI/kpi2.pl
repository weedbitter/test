#!/usr/bin/perl
use strict;
use Data::Dump;

my %ahash;
my %bhash;

open INa1,"<", "A1" or die; 
while(<INa1>) {
    s/^\s+//g;
    s/\s+$//g;
    next if /^$/;
    $ahash{$_} += 1;
}
Data::Dump->dump(\%ahash);
close INa1;



open INa2, "<", "A2" or die;
while(<INa2>) {
    s/^\s+//g;
    s/\s+$//g;
    next if /^$/;
    $ahash{$_} += 1;
}
Data::Dump->dump(\%ahash);
close INa2;


open INb1, "<", "B1" or die;
while(<INb1>) {
    s/^\s+//g;
    s/\s+$//g;
    next if /^$/;
    $bhash{$_} += 1;
}
close INb1;
Data::Dump->dump(\%bhash);

open INb2, "<", "B2" or die;
while(<INb2>) {
    s/^\s+//g;
    s/\s+$//g;
    next if /^$/;
    $bhash{$_} += 1;
}
Data::Dump->dump(\%bhash);
close INb2;

open WR,">", "C" or die;
foreach my $key ( keys %ahash ) {
    if($ahash{$key} == 2 && $bhash{$key} != 2){
        print "a:$key: $ahash{$key}\n"; 
        print "b:$key: $bhash{$key}\n"; 
        print WR "$key\n"; 
        print "$key\n"; 
    }
}
close WR;
