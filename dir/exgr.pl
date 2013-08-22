#!/usr/bin/perl
use strict;
use warnings;

my $file_path = '/home/ngy/workspace/learn/jksc';
while(<$file_path/*.csv>){
#for (@files) {
    $_ =~ /([^\/]+\.csv)$/;
    warn ($1);
}
