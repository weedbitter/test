use Carp qw/cluck confess/;

sub f1 {
   &f2;
}

sub f2 {
   &f3;
}

sub f3 {
   &f4;
}

sub f4 {
    confess "I can not be called";
}

cluck "hello 1";
cluck "hello 2j";
cluck "hello";
cluck "hello";

&f1();
