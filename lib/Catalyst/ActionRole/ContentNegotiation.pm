package Catalyst::ActionRole::ContentNegotiation;

{
  package Catalyst::Request;

  use HTTP::Headers::Util qw(split_header_words);

  sub acceptable_types { map { $_->[0] } split_header_words(shift->header('Accept')) }

  sub accepts {

    ## Given a array of content types, is there at least one acceptable
    ## match in the client HTTP-Accept header? Used to determine if the
    ## server can Provide what a client is asking for. Returns boolean
    
    my ($self, @provided) = @_;
    my @accepts = $self->acceptable_types;
    my @matches = grep { my $outer = $_; grep { $_ == $outer } @provided } @accepts;

    return @matches ? 1:0;
  }

  1;

}
use Moose::Role;
use Plack::MIME;

sub _spec_from_attr {
  my ($self, $attr) = @_;
  return ($self->attributes->{$attr}||[])->[0];
}

sub _mimetype_from_spec {
  my ($self, $spec) = @_;
  if($self->_looks_like_a_mimetype($spec)) {
    return $spec;
  } elsif(my $normalized = Plack::MIME->mime_type(".$spec")) {
    return $normalized;
  } else {
    die "We can't find a matching mimetype for $spec";
  }
}

sub _looks_like_a_mimetype {
  my ($self, $possible_type) = @_;
  return $possible_type =~m/^.+?\/.+?$/ ? 1:0;
}

around ['match','match_captures'] => sub {
  my ($orig, $self, $ctx, @args) = @_;

  ## Do I provide what you are willing to accept?
  if(my $spec = $self->_spec_from_attr('Provides')) {
    my $type = $self->_mimetype_from_spec($spec);
    return 0 unless $ctx->req->accepts($type);
  }

  ## Can I consume what you are giving me?
  if(my $spec = $self->_spec_from_attr('Consumes')) {
    my $mimetype = $self->_mimetype_from_spec($spec);
    if(my $content_type = $ctx->req->content_type) {
      return 0 unless $self->does_consume($mimetype, $content_type);
    }
  }
  
  $self->$orig($ctx, @args);
};

sub does_consume {
  my ($self, $mimetype, $request_content_type) = @_;
  return ($mimetype =~/$request_content_type/i);
}

1;

=head1 NAME

Catalyst::ActionRole::ContentNegotiation

=head1 AUTHORS

Catalyst Contributors, see L<Catalyst>.

=head1 COPYRIGHT

This library is free software. You can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

