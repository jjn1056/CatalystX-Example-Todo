package CatalystX::Example::Todo::Web::Controller::Task;
 
use Moose;
use MooseX::MethodAttributes;
use CatalystX::Syntax::Action;

extends 'CatalystX::Example::Todo::Web::Controller';

action start($task_id) : Chained('/start')
 PathPrefix CaptureArgs(1) {
  $ctx->stash(current_model_instance
    => $ctx->model->find($task_id));
 }

  action remove : Chained('start')
   PathPart('') Args(0) Method('POST') {
    $ctx->model->delete;
    $ctx->res->redirect($ctx->req->query_parameters->{next});
  }

 
__PACKAGE__->meta->make_immutable;
