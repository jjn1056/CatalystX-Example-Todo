package CatalystX::Example::Todo::Web::Model::FormNewEntry;

use Moose;
extends 'Catalyst::Model::Factory::PerRequest';

around 'prepare_arguments', sub {
  my ($orig, $self, $ctx, $arg) = @_;
  my %extra = (
    item => $ctx->model('Schema::TodoList')
      ->new_result({status=>'open'}));

  return $self->$orig($ctx, { %$arg, %extra });
};

__PACKAGE__->config(
  class => 'CatalystX::Example::Todo::Web::NewTodoForm' );
