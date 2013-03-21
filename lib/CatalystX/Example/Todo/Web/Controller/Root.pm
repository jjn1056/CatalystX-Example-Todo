package CatalystX::Example::Todo::Web::Controller::Root;
 
use Moose;
use MooseX::MethodAttributes;
use Catalyst::ResponseHelpers;
no warnings::illegalproto;

extends 'CatalystX::Example::Todo::Web::Controller';

sub start : Chained('/')
 PathPrefix CaptureArgs(0) { }

  sub root(Controller::Tasks) : Chained('start')
   PathPart('') Args(0)
  {
    my ($self, $tasks_cntrl) = @_;
    SeeOther UriOf $tasks_cntrl->action_for('list');
  }

__PACKAGE__->meta->make_immutable;
