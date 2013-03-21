package Catalyst::ActionRole::DependencyInjector;

use Moose::Role;

around 'execute', sub {
  my ($orig, $self, $controller, $ctx, @args) = @_;

  my @dependencies;
  if(my $proto = prototype(ref($controller) ."::". $self->name)) {
    foreach my $what (split(',',$proto)) {
      push @dependencies, $ctx if $what eq 'ctx';
      push @dependencies, $ctx->req->body_parameters if $what eq 'bparams';
      push @dependencies, $ctx->session if $what eq 'session';
      push @dependencies, $ctx->req if $what eq 'req';

      if(my $model = ($what =~/^Model\:\:(.+)$/)[0]) {
        push @dependencies, $ctx->model($model);
      }
      if(my $controller = ($what =~/^Controller\:\:(.+)$/)[0]) {
        push @dependencies, $ctx->controller($controller);
      }
    }
  } else {
    @dependencies = ($ctx, @args);
  }

  return $self->$orig($controller, @dependencies);
};

1;
