#!/usr/bin/perl
use warnings;

$pattern = ' simple always simple';

$result = ($pattern =~ m"simple");
warn $result;
$result = ($pattern =~ m"simple"g);##   无g操作

warn $result;
$result = ($pattern =~ s" simple" complex");

warn $result;
$pattern = ' simple simple';

$result = ($pattern =~ s/simple/complex/g);
warn $result;

warn $pattern;
if ($pattern =~ m" simple")
{
	print " MATCHED!/n";
}
