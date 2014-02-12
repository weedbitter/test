#!usr/bin/perl
use warnings;
use strict;
use IO::Socket;
use POE qw /Wheel::SocketFactory Wheel::ReadWrite Wheel::ReadLine/;

POE::Session->create(
    inline_states => {
        _start       => \&start_chat,
        connected    => \&connected,
        connect_fail => \&connect_fail,
        server_input => \&server_input,
        user_input   => \&user_input,
    }
);

POE::Kernel->run;

sub start_chat {
    my $wheel = POE::Wheel::SocketFactory->new(
        RemoteAddress => 'localhost',
        RemotePort    => 8000,
        SuccessEvent  => "connected",
        FailureEvent  => "connect_fail",
    );
    $_[HEAP]->{server} = $wheel;
}

sub connected {
    my ( $kernel, $heap, $socket ) = @_[ KERNEL, HEAP, ARG0 ];
    my $wheel = POE::Wheel::ReadWrite->new(
        Handle     => $socket,
        InputEvent => "server_input",
        ErrorEvent => "error_happened",
    );
    $heap->{server} = $wheel;
    my $console = POE::Wheel::ReadLine->new( InputEvent => 'user_input' );

    # 告诉ReadLine监控终端
    $console->get('input your message, bye to quit: ');
    $heap->{console} = $console;
}

sub connect_fail {
    delete $_[HEAP]->{server};
}

sub server_input {
    my ( $heap, $input ) = @_[ HEAP, ARG0 ];

    # 如果使用print "$input\n"会搞乱终端
    $heap->{console}->put($input);
}

sub user_input {
    my ( $heap, $input ) = @_[ HEAP, ARG0 ];
    if ( $input =~ /(quit)|(exit)|(bye)/i ) {
        delete $heap->{server};
        delete $heap->{console};
        return;
    }

    # 发送到服务端
    $heap->{server}->put($input);

    # 继续监控终端
    $heap->{console}->get('input your message, bye to quit: ');
}
