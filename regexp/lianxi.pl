#!/usr/bin/perl
use strict;
use warnings;
use Data::Dump;


print "{\n";
while(<DATA>) {
    s/^\s+//g;
    s/\s+$//g;
	next if /^$/;
	
	my ($key1,@data) = split;
    &jx($key1,@data);
}
print "}\n";

sub jx {
	my $key1 = shift;
	print "    $key1 =>{\n";
	$_ =~ m/([A-Za-z]+)_/;
	print "        $1 =>{\n";
	for(@_) {
		if($_ =~ m/([A-Za-z]+)_([A-Za-z]+)=(\d)/){
			print "            $2 =>";
			print "$3 ,\n";
		}
	}
	print "        }\n";
    print "    }\n";

}


__END__

A      BUS_x=1      BUS_y=2   BUS_z=3   
B      BUS_x=1      KEN_y=2   BUS_z=3  
A      BUS_x=1      BUS_y=2   BUS_z=3   


