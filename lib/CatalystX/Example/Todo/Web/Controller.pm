package CatalystX::Example::Todo::Web::Controller;
 
use Moose;

extends 'Catalyst::Controller';

__PACKAGE__->config(
  action_roles => ['MatchRequestMethod','QueryParameter'],
);
