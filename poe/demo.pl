#!usr/bin/perl
use warnings;
use strict;

use POE;
use POE::Wheel::SocketFactory;
use POE::Wheel::ReadWrite;

POE::Session->create(
    inline_states => {
        _start    => \&start,
        connected => \&connected,
        flushed   => \&flushed,
    }
);

POE::Kernel->run;

sub start {
    print "_start\n";
    my $wheel = POE::Wheel::SocketFactory->new(
        RemoteAddress => 'localhost',
        RemotePort    => 8000,
        SuccessEvent  => "connected",
        FailureEvent  => "_stop",
    );
    $_[HEAP]->{wheel} = $wheel;
}

sub connected {
    print "connected\n";
    my ( $kernel, $heap, $socket ) = @_[ KERNEL, HEAP, ARG0 ];
    my $wheel = POE::Wheel::ReadWrite->new(
        Handle       => $socket,
        FlushedEvent => 'flushed',
    );
    $heap->{wheel} = $wheel;
    $wheel->put("hello server");
}

sub flushed {
    print "flushed\n";
    delete $_[HEAP]->{wheel};
}
