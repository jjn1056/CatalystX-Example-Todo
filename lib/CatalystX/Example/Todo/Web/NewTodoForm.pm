package CatalystX::Example::Todo::Web::NewTodoForm;

use Moose;
use HTML::FormHandler::Moose;

extends 'HTML::FormHandler';
with 'HTML::FormHandler::TraitFor::Model::DBIC';

has_field 'entry' => (
  required => 1,
  minlength => 3,
  maxlength => 64,
  type => 'Text');

__PACKAGE__->meta->make_immutable;
