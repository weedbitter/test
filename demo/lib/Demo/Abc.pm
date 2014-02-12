package Demo::Abc;
use Mojo::Base qw/Mojolicious::Controller/;

sub index {
    shift->redirect_to('/k.html');
}

1;


