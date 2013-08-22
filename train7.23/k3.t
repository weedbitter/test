#!/usr/bin/perl
use List::Util qw/reduce/;

# 10!
$foo = reduce { $a * $b } 1 .. 10;
warn "$foo\n";

