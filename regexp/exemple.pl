#!/usr/bin./perl
use Data::Dump;

my %hash;
while(<DATA>) {
    s/^\s+//g;
    s/\s+$//g;
    next if /^$/;

    my ($key, @other) = split;
    map { /([A-Za-z]+)_([A-Za-z]+)=(\d+)/; 
	   $hash{$key}{$1}{$2} += $3; } @other;
   }

Data::Dump->dump(\%hash);


__END__
A      BUS_x=1      BUS_y=2   BUS_z=3   
B      BUS_x=1      KEN_y=2   BUS_z=3  
A      BUS_x=1      BUS_y=2   BUS_z=3 

