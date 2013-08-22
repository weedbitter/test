#!/usr/bin/perl -w
use strict;
use person;
use dog;

sub main() {
    my $object = { "name" => "tom" };

    # 先把"tom"变为人
    bless( $object, "person" );
    $object->sleep();
    $object->study();

    # 再把"tom"变为狗
    bless( $object, "dog" );
    $object->sleep();
    $object->bark();

    # 最后，再把"tom"变回人
    bless( $object, "person" );
    $object->sleep();
    $object->study();
}

&main;
