package CatalystX::Example::Todo::Web::Model::FormNewEntry;

use Moose;
use CatalystX::Example::Todo::Web::NewTodoForm;

with 'Catalyst::Component::InstancePerContext';
 
sub build_per_context_instance {
    my ($self, $ctx, $todolist) = @_;
    return CatalystX::Example::Todo::Web::NewTodoForm
      ->new( item => $todolist
        ->new_result({status=>'open'}));
}


