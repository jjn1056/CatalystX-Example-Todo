package CatalystX::Example::Todo::Schema::ResultSet;

use strictures;
use base 'DBIx::Class::ResultSet';

__PACKAGE__->load_components(qw/
  Helper::ResultSet::IgnoreWantarray
  Helper::ResultSet::Me
  Helper::ResultSet::Random
  Helper::ResultSet::SetOperations
  Helper::ResultSet::ResultClassDWIM
  Helper::ResultSet::RemoveColumns
  Helper::ResultSet::NoColumns 
  Helper::ResultSet::SearchOr
  Helper::ResultSet::Shortcut
/);

sub map {
  my ($self, $cr) = @_;
  my @results;
  while(my $row = $self->next) {
    local $_ = $row;
    push @results,
      $cr->($row, $self);
  }
  return @results;
}

1;

=head1 NAME

CatalystX::Example::Todo::Schema::ResultSet - A base ResultSet Class

=head1 SYNOPSIS

    package CatalystX::Example::Todo::Schema::ResultSet::User;
    use parent 'CatalystX::Example::Todo::Schema::ResultSet';
	
=head1 DESCRIPTION

All ResultSet classes should inherit from this.  This provides some base
methods that you can share across all the resultsets.  Good things to put here
would include utilties useful for all resultsets and inflator classes.

Please see the documentation for  L<DBIx::Class::Helpers> in order to
understand included component functionality.

=head1 METHODS

This package defines the following methods.

=head2 map

    my @items = my $resultset->map(sub { ... });

Given a subroutine, execute it against each row in the resultset and
return an array of results.  C<$_> is localized to $row, but C<$row> and 
<$resultset> are passed as ARGS.

=head1 AUTHOR

See L<CatalystX::Example::Todo> for authorship information.

=head1 COPYRIGHT & LICENSE

See L<CatalystX::Example::Todo> for rights information.

=cut

