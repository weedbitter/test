#!/usr/bin/perl
use strict;
use Data::Dump;

my %hash;
my $key; 
while(<DATA>) {
    s/^\s+//g;
    s/\s+$//g;
    next if /^$/;

    if( /\[(.+)\]/){
        $key = $1;
        print "$key\n";    
    }
    elsif(/(.+)\s*=\s*(.+)/){
        my @other = split;
        print "$1\n";    
        print "$2\n";    
        map { $hash{$key}{$1} = $2; } @other;
    }
    else {
        next;
    }
}




Data::Dump->dump(\%hash);


__END__
[section1]
k1 = v1
k2 = v2

[section2]
k1 = v1
k2 = v2
