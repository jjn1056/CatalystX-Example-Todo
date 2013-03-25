package CatalystX::Example::Todo::Web::Controller::AjaxTasks;
 
use Moose;
use MooseX::MethodAttributes;
use Catalyst::ResponseHelpers;
no warnings::illegalproto;

extends 'CatalystX::Example::Todo::Web::Controller';

sub start : ChainedParent PathPrefix CaptureArgs(0) { }

  sub index : Chained('start')
   PathPart('') Args(0)
  {
    Ok html { };
  }

__PACKAGE__->meta->make_immutable;
