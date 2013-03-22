package CatalystX::Example::Todo::Web::Controller::Tasks;
 
use Moose;
use MooseX::MethodAttributes;
use Catalyst::ResponseHelpers;
no warnings::illegalproto;

extends 'CatalystX::Example::Todo::Web::Controller';

sub start : Chained('/start')
 PathPrefix CaptureArgs(0) { }

  sub list(Model::Schema::TodoList)
   : Chained('start') GET PathPart('') Args(0)
  {
    my ($self, $todolist) = @_;
    Ok html {todolist => [$todolist->hri->all]};
  }

  sub add(bparams, Model::FormNewEntry<Model::Schema::TodoList>)
   : Chained('start') POST PathPart('') Args(0)
  {
    my ($self, $params, $form) = @_;
    my $result = $form->run($params);

    if($result->validated) {
      SeeOther UriOf $self->action_for('list');
    } else {
      Ok html {entry => $result->value->{entry},
        errors => $result->errors};
    }
  }

__PACKAGE__->meta->make_immutable;
