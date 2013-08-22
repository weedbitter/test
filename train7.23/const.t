#!/usr/bin/perl

#
#  define HARY 10
#
use Data::Dump;

use constant HARY => 10;
use constant {
    K => 1,
    T => 2,
};


$a[K] = 10;
$a[T] = 20;
$a[HARY] = 100;

Data::Dump->dump(\@a);
