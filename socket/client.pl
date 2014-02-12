#!/usr/bin/perl

####################
# SEND FILE CLIENT #
####################

use IO::Socket ;
use Time::Elapse;
Time::Elapse->lapse(my $now = "db2insert");

$bandwidth = 1024*5 ; # 5Kb/s
my $file = "tt";
&send_file($ARGV[1]||'127.0.0.1' , $ARGV[2]||6123, $file) ;

print $now . "\n";


exit;

#############
# SEND_FILE #
#############

sub send_file {
    my ( $host , $port , $file ) = @_ ;
    print "Host: $host, Port: $port, File: $file\n";

    if (! -s $file) { die "ERROR! Can't find or blank file $file" ;}
    my $file_size = -s $file ;

    my ($file_name) = ( $file =~ /([^\\\/]+)[\\\/]*$/gs );

    my $sock = new IO::Socket::INET(
        PeerAddr => $host,
        PeerPort => $port,
        Proto    => 'tcp',
        Timeout  => 300) ;

    if (! $sock) { die "ERROR! Can't connect $!\n" ;}
    $sock->autoflush(1);

    print "Sending $file_name\n$file_size bytes." ;

    print $sock "$file_name#:#" ; # send the file name.
    print $sock "$file_size\_" ; # send the size of the file to server.

    open (FILE,$file) ; binmode(FILE) ;

    my $buffer ;
    while( sysread(FILE, $buffer , $bandwidth) ) {
        print $sock $buffer ;
        print "...  ... |" ;
        sleep(1) ;
    }

    print "OK\n\n" ;

    close (FILE) ;
    close($sock) ;
}

#######
# END #
#######
