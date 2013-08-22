#!/usr/bin/perl
use Data::Dump;

sub add {
    return $_[0] + $_[1];
}



sub line_add {
    my (@a1, @a2) = @_;   # ("Data::Dump", [1, 2, 1, 2], [])
    Data::Dump->dump(\@a1, \@a2);
}

sub line_add_2 {
    my ($a1, $a2) = @_;   # ("Data::Dump", [1, 2, 1, 2], [])
  
    my $cnt1 = $#$a1;
    my $cnt2 = $#$a2;
    warn "cnt1 => $cnt1 cnt2 => $cnt2";
    
    my @res;
    for (0 .. $cnt1) {
        warn "$a1->[$_] + $a2->[$_]";
        $res[$_] = $a1->[$_]+ $a2->[$_];
    }
    return \@res;
}

my @param1 = (1,2);
my @param2 = (1,2);

warn &add(1,2);
warn &add(@param1);

my $res = &line_add_2(\@param1, \@param2);
Data::Dump->dump($res);



