package CatalystX::Example::Todo::Web::Model::TodoListViewBuilder;

use Moose;
with 'Catalyst::Component::InstancePerContext';

sub build_per_context_instance {
    my ($self, $ctx, $todolist) = @_;
    [map { +{
      $_->get_columns,
      is_open => ($_->status eq 'open' ? 1:0),
      remove_action => 'task/remove',
    } } $todolist->all];
}



