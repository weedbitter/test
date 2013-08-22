#!/usr/bin/perl
use Data::Dump;

my $aref_2d;
while(<DATA>) {
   s/^\s+//g;
   s/\s$//g;
   next if /^$/;
   push @{$aref_2d}, [ split ];
}

Data::Dump->dump($aref_2d);

__END__
1 2 3 
4 5 6
7 8 9
