#!/usr/bin/perl
use strict;
use warnings;

my @array1 = ("var111","var","var3");
#----   =~ 只能使用在标量上  ----------------------
if($array1[1] =~ m/var/){
	warn (" find var");
}

if($array1[2] =~ m/2/){
	warn (" can match 2");
}
#-------------------------------
if(grep(m/111/,@array1) > 0){
	warn (" find 111");
}
