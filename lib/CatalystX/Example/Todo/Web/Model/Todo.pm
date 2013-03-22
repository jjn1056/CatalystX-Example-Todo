package CatalystX::Example::Todo::Web::Model::Todo;

use Moose;
with 'Catalyst::Component::InstancePerContext';
 
sub build_per_context_instance {
    my ($self, $ctx, $todolist, $id) = @_;
    return $todolist->find($id);
}
