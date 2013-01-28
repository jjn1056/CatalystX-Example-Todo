package CatalystX::Example::Todo::Web::Controller::Root;
 
use Moose;
use MooseX::MethodAttributes;
use CatalystX::Syntax::Action;

extends 'CatalystX::Example::Todo::Web::Controller';

action start : Chained('/')
 PathPrefix CaptureArgs(0) { }

  action root : Chained('start') PathPart('') Args(0) {
    $ctx->response->redirect(
     $ctx->uri_for_action(
      $ctx->controller('Tasks')->action_for('list')));
  }

action end : ActionClass('RenderView') { }
 
__PACKAGE__->meta->make_immutable;
