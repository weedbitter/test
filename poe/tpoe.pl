#!/usr/bin/perl
use warnings;
use strict;
use POE;

POE::Session->create(
    inline_states =>
      {
        _start => \&session_start,
        _stop => \&session_stop,
        count => \&session_count,
      }
);

print "启动 POE 内核...\n";
POE::Kernel->run();
print "POE 内核运行结束。\n";

exit;

sub session_start {
    print "Session 启动。Session ID = ", $_[SESSION]->ID, "\n";
    $_[HEAP]->{count} = 0;
    $_[KERNEL]->yield("count");
}

sub session_stop {
    print "Session 停止。Session ID = ", $_[SESSION]->ID, ".\n";
}

sub session_count {
    my ( $kernel, $heap ) = @_[ KERNEL, HEAP ];
    my $session_id = $_[SESSION]->ID;
    my $count = ++$heap->{count};
    print "数数 $count\n";
    $kernel->yield("count") if $count < 10;
}
