package Catalyst::ActionRole::DependencyInjector;

use Moose::Role;
      use Devel::Dwarn;

sub _parse_dependencies {
  my ($self, $proto, $controller, $ctx, @args) = @_;
  my @dependencies;

  my $p = qr/[^,]+/;
  my $p2 = qr/$p<.+?>/x;

  foreach my $what ($proto=~/($p2|$p)/gx) {
    push @dependencies, $ctx if $what eq 'ctx';
    push @dependencies, $ctx->req->body_parameters if $what eq 'bparams';
    push @dependencies, $ctx->session if $what eq 'session';
    push @dependencies, $ctx->req if $what eq 'req';

    if(defined(my $arg_index = ($what =~/^Arg(.+)$/)[0])) {
      push @dependencies, $ctx->req->args->[$arg_index];
    }

    if(my $model = ($what =~/^Model\:\:(.+)$/)[0]) {
      my @inner_deps = ();
      if(my $extracted = ($model=~/.+?<(.+)>$/)[0]) {
        @inner_deps = $self->_parse_dependencies($extracted, $controller, $ctx, @args);
        ($model) = ($model =~ /^(.+?)</);
      }

      my ($ret, @rest) = $ctx->model($model, @inner_deps);
      warn "$model returns more than one arg" if @rest;
      push @dependencies, $ret;
    }
    if(my $controller = ($what =~/^Controller\:\:(.+)$/)[0]) {
      push @dependencies, $ctx->controller($controller);
    }
  }
  return @dependencies;
}

around 'execute', sub {
  my ($orig, $self, $controller, $ctx, @args) = @_;

  my @dependencies;
  if(my $proto = prototype(ref($controller) ."::". $self->name)) {
    @dependencies = $self->_parse_dependencies($proto, $controller, $ctx, @args);
  } else {
    @dependencies = ($ctx, @args);
  }

  return $self->$orig($controller, @dependencies);
};

1;
