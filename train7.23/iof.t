#!/usr/bin/perl
use IO::File;


$fh = IO::File->new(">filename");
$fh = IO::File->new(">>filename");
$fh = IO::File->new("<filename");


$fh->print();

print $fh "asfasfaf";

@all = <$fh>;
while(<$fh>) {
}





