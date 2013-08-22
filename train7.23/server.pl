#!/usr/bin/perl

use IO::Socket::INET;

my $sock = IO::Socket::INET->new(
      Listen    => 5,
      Proto     => 'tcp',
      LocalAddr => '127.0.0.1',
      LocalPort => '9999',
      ReuseAddr => 1,
);

warn "sock is created";

while(my $cli =$sock->accept()) {
    my $msg = <$cli>;
    $cli->print($msg, "\n");
    close $cli;
}

