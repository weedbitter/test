#!/usr/bin/perl
use JSON::XS qw/encode_json decode_json/;

#
# json
# hessian
# protobuf
# msgpack
# xml
#

my $d = {
   name => [ 'first', 'last' ],
   neib => [ qw/a b c/ ],
   grade => {
       math     => [ 100, 90 ],
       physics => [ 100, 90 ],
   },
};

$str = encode_json($d);

warn "[$str]\n";

my $d2 = decode_json($str);
use Data::Dump;
Data::Dump->dump($d2);






