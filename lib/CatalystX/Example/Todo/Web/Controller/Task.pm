package CatalystX::Example::Todo::Web::Controller::Task;
 
use Moose;
use MooseX::MethodAttributes;
use Catalyst::ResponseHelpers;
no warnings::illegalproto;

extends 'CatalystX::Example::Todo::Web::Controller';

sub start(Model::Todo<Model::Schema::TodoList,Arg0>)
 : Chained('/start') PathPrefix CaptureArgs(1)
{
  my ($self, $todo) = @_;
  NotFound unless $todo;
 }

  sub remove(Model::Todo, Controller::Tasks)
   : Chained('start') POST PathPart('') Args(0)
  {
    my ($self, $todo, $tasks_cntrl) = @_;
    $todo->delete;
    SeeOther UriOf $tasks_cntrl->action_for('list');
  }

__PACKAGE__->meta->make_immutable;
