package CatalystX::Example::Todo::Web::Controller::API;
 
use Moose;
use MooseX::MethodAttributes;
use Catalyst::ResponseHelpers;
no warnings::illegalproto;

extends 'CatalystX::Example::Todo::Web::Controller';

sub start : ChainedParent
 PathPrefix CaptureArgs(0) { }

  sub todolist(Model::Schema::TodoList)
   : GET Chained('start') Args(0)
  {
    my ($self, $todolist) = @_;
    Ok json +{todolist => [$todolist->hri->all]};
  }

  sub add(bparams, Model::FormNewEntry<Model::Schema::TodoList>)
   : Chained('start') POST PathPart('todolist') BodyParser('Any') Args(0)
  {
    my ($self, $params, $form) = @_;
    my $result = $form->run($params);

    if($result->validated) {
      Ok json +{entry => {$result->form->item->get_columns}};
    } else {
      NotAcceptable json {errors => $result->errors}
    }
  }

  sub delete(Model::Todo<Model::Schema::TodoList,Arg0>)
   : Chained('start') DELETE PathPart('todolist') Args(1)
  {
    my ($self, $todo) = @_;
    if($todo) {
      $todo->delete;
      return SeeOther UriOf 'tasks/list';
    } else {
      return NotFound;
    }
  }

__PACKAGE__->meta->make_immutable;



