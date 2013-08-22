#!/usr/bin/perl
use Time::HiRes qw/sleep gettimeofday tv_interval/;

sub work {
    sleep 3.3;
}

my $t1 = [ gettimeofday ];
work();
# my $t2 = [ gettimeofday ];

my $elapse = tv_interval($t1);
warn "work consumed $elapse";


