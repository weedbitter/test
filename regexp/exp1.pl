#!/usr/bin/perl
use strict;
use warnings;
use Data::Dump;


my @elements = (' al' ,' a2' ,' a3' ,' a4' ,' a5' );

foreach (@elements) {s/a/b/;}
Data::Dump->dump(@elements);

foreach (@elements) {tr/a-z/A-Z/;}
Data::Dump->dump(@elements);

foreach (@elements) {
	my $tmp = $_;
	warn $tmp;
	if($tmp =~ /2/){ 
		s/B/b/;
	}
}
Data::Dump->dump(@elements);

foreach (@elements) {
	my $tmp = $_;
	if($tmp !~ /3/){ 
		tr/A-Z/a-z/;
	}
}
Data::Dump->dump(@elements);
