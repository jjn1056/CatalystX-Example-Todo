package CatalystX::Example::Todo::Web::Controller::Tasks;
 
use Moose;
use MooseX::MethodAttributes;
use CatalystX::Syntax::Action;

extends 'CatalystX::Example::Todo::Web::Controller';

action start : Chained('/start')
 PathPrefix CaptureArgs(0) { 
  $ctx->stash(current_model => 'Schema::TodoList');
}

  action list :Chained('start')
   PathPart('') Args(0) Method('GET') {
    $ctx->stash(todolist=>[$ctx->model->hri->all]);
  }

  action add :Chained('start')
   PathPart('') Args(0) Method('POST') {
    $ctx->model->create({
      entry=>$ctx->req->body_parameters->{new_entry},
      status=>'open'});
    $ctx->res->redirect($ctx->req->query_parameters->{next});
   }

__PACKAGE__->meta->make_immutable;
