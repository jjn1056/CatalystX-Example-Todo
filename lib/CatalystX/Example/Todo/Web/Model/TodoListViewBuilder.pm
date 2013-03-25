package CatalystX::Example::Todo::Web::Model::TodoListViewBuilder;

use Moose;
with 'Catalyst::Component::InstancePerContext';

{
  package CatalystX::Example::Todo::Web::TodoListView;

  use Moose;

  CatalystX::Example::Todo::Web::TodoListView->meta->make_immutable;
}
 
sub build_per_context_instance {
    my ($self, $ctx, $todolist) = @_;
    return CatalystX::Example::Todo::Web::NewTodoForm
      ->new( item => $todolist
        ->new_result({status=>'open'}));
}


