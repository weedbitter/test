package Demo;
use Mojo::Base 'Mojolicious';

use Data::Dump;


# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes;

  push @{$self->app->static->paths}, '/home/ngy/';    # PATH  PER5LIb


  # Normal route to controller
  $r->get('/')->to('example#welcome');
  $r->get('/ngy')->to('ngy#index');
  $r->get('/abc')->to('abc#index');
  Data::Dump->dump($self);

}

1;
