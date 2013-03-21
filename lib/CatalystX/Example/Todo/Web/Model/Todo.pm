package CatalystX::Example::Todo::Web::Model::Todo;

use Moose;
with 'Catalyst::Component::InstancePerContext';
 
sub build_per_context_instance {
    my ($self, $ctx) = @_;
    return $ctx->model('Schema::TodoList')
     ->find($ctx->req->args->[0]);
}
