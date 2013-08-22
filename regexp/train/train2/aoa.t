#!/usr/bin/perl
use Data::Dump;

my @array_2d;

while(<DATA>) {
   s/^\s+//g;
   s/\s$//g;
   next if /^$/;

   push @array_2d, [ split ];
}

Data::Dump->dump(\@array_2d);

__END__
1 2 3 
4 5 6
7 8 9
