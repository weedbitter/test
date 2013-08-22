#!/usr/bin/perl
use Data::Dump;

my @array_2d;
my $i = 0;
while(<DATA>) {
   s/^\s+//g;
   s/\s$//g;
   next if /^$/;

   my @a = split;
   $array_2d[$i++] = [ @a ];    # Wrong!!

#----------------   
#   shift @a;
}

Data::Dump->dump(\@array_2d);

__END__
1 2 3 
4 5 6
7 8 9
