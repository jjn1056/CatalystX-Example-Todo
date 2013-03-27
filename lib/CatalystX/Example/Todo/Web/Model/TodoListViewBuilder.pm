package CatalystX::Example::Todo::Web::Model::TodoListViewBuilder;

use Moose;
with 'Catalyst::Component::InstancePerContext';

sub build_per_context_instance {
    my ($self, $ctx, $todolist) = @_;
    [map { +{ $_->get_columns, remove_action => 'task/remove' } } $todolist->all];
}



