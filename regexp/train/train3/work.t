#!/usr/bin/perl
use Data::Dump;

my %set;
my $cur;
while(<DATA>) {
    s/^\s+//g;
    s/\s+$//g;
    next if /^$/;

    if (/\[(\w+)\]/) {
        $cur =  $1;
        next;
    }
    push @{$set{$cur}}, $_;
}

Data::Dump->dump(\%set);
$a_and_b = &set_and($set{A}, $set{B});
$c_and_d = &set_and($set{C}, $set{D});
$final   = &set_sub($a_and_b, $c_and_d);
Data::Dump->dump($a_and_b, $c_and_d, $final);

sub set_and {
    my ($s1, $s2) = @_;    ####
    my %and;
    my @and;
    for (@$s1, @$s2) {
        $and{$_}++;
    }
    for (keys %and) {
         push @and, $_ if $and{$_} == 2;
    }
    return \@and;
}

sub set_sub {
    my ($s1, $s2) = @_;
    my %sub;
    my @sub;
    for (@$s1) {
        $sub{$_}++;
    }
    for (@$s2) {
        $sub{$_}--;
    }
    for (keys %sub) {
        push @sub, $_ if $sub{$_} == 1;
    }
    return \@sub;
}


__END__
[A]
k1
k2
k3
k4

[B]
k2
k3
k4

[C]
k4
k5

[D]
k4
k5
k6

