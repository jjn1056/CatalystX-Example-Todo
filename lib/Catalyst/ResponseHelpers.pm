package Catalyst::ResponseHelpers;

use strict;
use warnings;
use base qw(Exporter);
use JSON;
 
our @EXPORT = qw(Ok NotAcceptable UriOf SeeOther NotFound json html);

sub response_helper(&) { bless shift, __PACKAGE__ . '::__Helper' }

sub Ok($) {
  my $body_cb = shift;
  response_helper {
    my ($action, $controller, $ctx) = @_;
    $ctx->res->status(200);
    $ctx->res->body($body_cb->($action, $controller, $ctx));
  };
}

sub NotFound(;@) {
  my @next = @_;
  response_helper {
    my ($action, $controller, $ctx) = @_;
    $ctx->res->status(404);
    $ctx->res->body("The Requested Resource was not found");
    $ctx->detach;
  };
}

sub NotAcceptable(;@) {
  my $body_cb = shift;
  response_helper {
    my ($action, $controller, $ctx) = @_;
    $ctx->res->status(406);
    $ctx->res->body($body_cb->($action, $controller, $ctx));
  };
}

sub SeeOther($) {
  my $uri_of_cb = shift;
  response_helper {
    my ($action, $controller, $ctx) = @_;
    my $uri = $uri_of_cb->($action, $controller, $ctx);
    $ctx->res->redirect($uri,303);
  };
}

sub UriOf($) {
  my $target_action = shift;
  response_helper {
    my ($action, $controller, $ctx) = @_;
    $ctx->uri_for_action($target_action);
  };
}

sub json($) {
  my $template_vars = shift;
  response_helper {
    my ($action, $controller, $ctx) = @_;
    $ctx->res->content_type('application/json');
    encode_json($template_vars);
  };
}

sub html($) {
  my $template_vars = shift;
  response_helper {
    my ($action, $controller, $ctx) = @_;
    $ctx->res->content_type('text/html; charset=utf-8');
    $ctx->view('HTML')->render($ctx,"$action.tt", $template_vars);
  };
}

1;
