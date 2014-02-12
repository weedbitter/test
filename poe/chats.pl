#!usr/bin/perl
use warnings;

use strict;

use IO::Socket;

use POE qw /Wheel::ListenAccept Wheel::ReadWrite/;

# 创建监听Socket及处理Session

POE::Session->create(
    inline_states => {
        _start        => \&start_server,
        new_connected => \&new_connected,
        client_input  => \&client_input,
    }
);

POE::Kernel->run;

sub start_server {
    my ( $kernel, $heap ) = @_[ KERNEL, HEAP ];
    my $server = IO::Socket::INET->new(
        LocalPort => 8000,
        Listen    => 16,
        Reuse     => "yes",
    ) or die "can't make server socket: $@\n";
    $heap->{server} = POE::Wheel::ListenAccept->new(
        Handle      => $server,
        AcceptEvent => 'new_connected',
    );
}

sub new_connected {
    my ( $heap, $client ) = @_[ HEAP, ARG0 ];
    my $wheel = POE::Wheel::ReadWrite->new(
        Handle     => $client,
        InputEvent => 'client_input',
    );

    # 系统中每个wheel的ID是唯一的
    $heap->{client}->{ $wheel->ID } = $wheel;
}

sub client_input {
    my ( $heap, $input, $wid ) = @_[ HEAP, ARG0, ARG1 ];
    print "$input\n";
    $input = 'svr_' . $input; 

# 广播数据。如果愿意，可以屏蔽掉$wid，即发送消息的客户端
    map { $heap->{client}->{$_}->put($input) } keys %{ $heap->{client} };
}
