#!/usr/bin/perl
use Data::Dump;

#
#  \s  space  <===> \S
#  \d  digit  ====> \D
#  \w   \W
#
my %hash;
my @arr;
while( <DATA> ) {
    s/^\s+//g;
    s/\s+$//g;
    next if /^$/;

    @arr =  split ;
    Data::Dump->dump($arr);

    for my $i ( @arr ){
        print ("i:$i , arr; $arr[0] \n");
    }

    #my ($key, @other) = split;
    #map { /([A-Za-z]+)_([A-Za-z]+)=(\d+)/; 
    #$hash{$key}{$1}{$2} += $3; } @other;
}
Data::Dump->dump(\%hash);


__END__
A      BUS_x=1      BUS_y=2   BUS_z=3   
B      BUS_x=1      KEN_y=2   BUS_z=3  
A      BUS_x=1      BUS_y=2   BUS_z=3
