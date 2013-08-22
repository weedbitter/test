#!/usr/bin/perl
use IO::Socket::INET;


my $svr = IO::Socket::INET->new("127.0.0.1:9999");

$svr->print("hello world\n");
print <$svr>;

