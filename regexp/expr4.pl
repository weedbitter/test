#!/usr/bin/perl
use strict;
use warnings;

my $expression = 'm1';

my @arrayName = (' elem1', ' elem2');

if($arrayName[0] =~ m/$expression/){ # this equals m/m1/
     warn "array[1] can find m1.\n";
 }
if($arrayName[1] =~ m/$expression/){ # this equals m/m1/
     warn "array[2] can find m1.\n";
 }


if($arrayName[0] =~ m[$expression]){ # [] 允许被使用
     warn "array[1] can find m1.\n";
 }
if($arrayName[1] =~ m{$expression}){ # {}允许被使用
     warn "array[2] can find m1.\n";
 }

if($arrayName[0] =~ m"$expression"){ # "" 允许被使用
     warn "array[1] can find m1.\n";
 }

	
