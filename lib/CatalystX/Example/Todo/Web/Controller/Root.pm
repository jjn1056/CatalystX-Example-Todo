package CatalystX::Example::Todo::Web::Controller::Root;
 
use Moose;
use MooseX::MethodAttributes;
use Catalyst::ResponseHelpers;
no warnings::illegalproto;

extends 'CatalystX::Example::Todo::Web::Controller';

sub start : Chained('/')
 PathPrefix CaptureArgs(0) { }

  sub root : Chained('start')
   PathPart('') Args(0)
  {
    SeeOther UriOf 'tasks/list';
  }

__PACKAGE__->meta->make_immutable;
