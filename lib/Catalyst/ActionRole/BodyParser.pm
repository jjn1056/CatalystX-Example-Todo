package Catalyst::ActionRole::BodyParser;

use Moose::Role;

requires 'execute';

{
  package Catalyst::Request::BodyParser::Any;

  sub map {
    my ($class, $type) = @_;
    my $types = {
      'application/octet-stream'          => '',
      'application/x-www-form-urlencoded' => '',
      'multipart/form-data'               => '',
      'multipart/related'                 => '',
      'application/xml'                   => '',
      'application/json'                  => '_parse_json_body',
    };
    return $types->{$type};
  }

  sub parse {
    my ($class, $request) = @_;
    my $method = $class->map($request->content_type);
    return $class->$method($request->env->{'psgi.input'});
  }

  sub _memory_slurp {
    my ($class, $fh) = @_;
    return my $slurped_body = eval {
      local $/;
      $fh->seek(0, 0);
      my $body = readline($fh);
      $fh->seek(0, 0);
      $body;
    } || die "Can't decode POST'd params: $@";
  }

  use JSON;

  sub _parse_json_body {
    my ($class, $body_fh) = @_;
    decode_json $class->_memory_slurp($body_fh);
  }
}

sub body_parser {
  return our $body_parser ||= 
    do { ${shift->attributes->{BodyParser}||[]}[0] };
}

around 'execute', sub {
  my ($orig, $self, $controller, $ctx, @args) = @_;
  if(my $body_parser_type = $self->body_parser) {
    my $params = "Catalyst::Request::BodyParser::$body_parser_type"->parse($ctx->req);
    $ctx->req->body_parameters($params);
  }

  $self->$orig($controller, $ctx, @args);
};

1;

=head1 NAME

Catalyst::ActionRole::BodyParser

=head1 SYNOPSIS

    TBD

=head1 DESCRIPTION

    TBD

=head1 REQUIRES

This role requires the following methods in the consuming class.

=head2 execute

Modify how an action is executed.

=head1 METHODS

This role defines the following methods

=head1 AUTHORS

Catalyst Contributors, see L<Catalyst>.

=head1 COPYRIGHT

This library is free software. You can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

