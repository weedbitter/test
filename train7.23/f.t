use List::Util qw/first/;
@a;

$a[9] = 100;
$a[10] = 101;

my $b = first { defined $_ } @a;

warn "b is $b\n";


