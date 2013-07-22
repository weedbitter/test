#!/usr/bin/perl
use warnings;
use Data::Dump;

my %res;
while(<DATA>) {

   # 
   s/^\s+//g;
   s/\s+$//g;
   next if /^$/;

   my ($a, @data) = split;
   $res{$a} = &sum(@data); 
   Data::Dump->dump($res{$a});
   Data::Dump->dump(%res);
}

sub sum {
   my $sum;
   Data::Dump->dump(@_);
   for (@_) {
	   Data::Dump->dump($_);
       $sum += $_;
   }
   return $sum;
}

Data::Dump->dump(%res);
Data::Dump->dump(\%res);

#
#  a => 6
#  b => 10
#  c => 15
#
#("Data::Dump", 6)
#("Data::Dump", "a", 6)
#("Data::Dump", 10)
#("Data::Dump", "a", 6, "b", 10)
#("Data::Dump", 15)
#("Data::Dump", "c", 15, "a", 6, "b", 10)
#("Data::Dump", { a => 6, b => 10, c => 15 })
#

__END__
a 1 2 3

b 1 2 3 4

c 1 2 3 4 5

