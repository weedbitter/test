#!/usr/bin/perl
use strict;

our $a = 100 ;
our @a = ( 1, 2, 3 );
{
  no strict;
  my $b = "a";
  print "$$b\n";
  warn $$b[2];
}

