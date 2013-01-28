package CatalystX::Example::Todo::Schema;

use strictures;
use base 'DBIx::Class::Schema';

our $VERSION = 1;

__PACKAGE__->load_namespaces(
  default_resultset_class => 'DefaultRS',
);

1;

=head1 NAME

CatalystX::Example::Todo::Schema - Root Schema logic and ORM management

=head2 SYNOPSIS

	my $schema = CatalystX::Example::Todo::Schema->connect($dsn);

=head1 DESCRIPTION

Defines the core domain logic for the application platform.  Good methods to
put here would include everything related to deploying upgrading the database,
business methods that cut across multiple classes, and other logic related to
the database as a whole.

=head1 METHODS

This class defines the following methods

=head1 AUTHOR

See L<CatalystX::Example::Todo> for authorship information.

=head1 COPYRIGHT & LICENSE

See L<CatalystX::Example::Todo> for rights information.

=cut
