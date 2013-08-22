#!/usr/bin/perl

%hash = (
  1 => '3a',
  2 => '2b',
  3 => '1c',
);

# sort by key
for my $key (sort keys %hash) {
    warn "$key => $hash{$key}\n";
}

warn "--------------------\n";

# sort by value
for my $key ( sort { $hash{$a} <=> $hash{$b} } keys %hash) {
    warn "$key => $hash{$key}\n";
}


