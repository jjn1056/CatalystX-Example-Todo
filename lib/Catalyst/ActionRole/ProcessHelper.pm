package Catalyst::ActionRole::ProcessHelper;

use Moose::Role;

around 'execute', sub {
  my ($orig, $self, $controller, $ctx, @args) = @_;
  my ($return, @rest) = $self->$orig($controller, $ctx, @args);
  if(ref($return) =~m/Catalyst\:\:ResponseHelpers/) {
    return $return->($self, $controller, $ctx, @rest);
  } else {
    return ($return, @rest);
  }
};

1;
