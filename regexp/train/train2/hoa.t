#!/usr/bin/perl
use Data::Dump;

my %hoa;

while(<DATA>) {
   s/^\s+//g;
   s/\s$//g;
   next if /^$/;

   my ($key, @other) = split /[\s:]+/, $_;
   $hoa{$key} =  [ @other ];
}

Data::Dump->dump(\%hoa);

__END__
k1 : 1 2 3 7 8
k2 : 4 5 6
k3 : 7 8 9
