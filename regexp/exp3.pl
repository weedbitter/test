#!/usr/bin/perl
use strict;
use warnings;

my $var1 ='0000000';

sub myFunc1{
	my $var1 = shift;
	print "var1 = $$var1\n";
	$$var1 = "1111111";
}
sub   myFunc2{
	my $var1 = \$_[0];
	print "var1 = $$var1\n";
	$$var1 = "2222222";
}
sub   myFunc3{
	$_[0] = "33333";
}
print "var1 = $var1\n";
myFunc1(\$var1);
print "var1 = $var1\n";
myFunc2($var1);
print "var1 = $var1\n";
myFunc3($var1);
print "var1 = $var1\n";


my $var2 ='0000000';

sub myFunc4{
	my $var2 = shift;
	print "var2 = $var2\n";
	$var2 = "1111111";
}
sub   myFunc5{
	my $var2 = \$_[0];
	print "var2 = $var2\n";
	$var2 = "2222222";
}
sub   myFunc6{
	$_[0] = "33333";
}
print "var2 = $var2\n";
myFunc4(\$var2);
print "var2 = $var2\n";
myFunc5($var2);
print "var2 = $var2\n";
myFunc6($var2);
print "var2 = $var2\n";
