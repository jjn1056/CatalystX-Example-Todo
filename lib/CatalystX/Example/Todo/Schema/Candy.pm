package CatalystX::Example::Todo::Schema::Candy;

use strictures;
use base 'DBIx::Class::Candy';

sub base { $_[1] || 'CatalystX::Example::Todo::Schema::Result' }

1;

=head1 NAME

CatalystX::Example::Todo::Schema::Candy - My Candy Class

=head1 SYNOPSIS

	package CatalystX::Example::Todo::Schema::Result::User;
  use CatalystX::Example::Todo::Schema::Candy;

=head1 DESCRIPTION

Our custom subclass of L<DBIx::Class::Candy>

=head1 METHODS

This module defines the following methods.

=head2 base

Sets the base class for all Results

=head1 AUTHOR

See L<CatalystX::Example::Todo> for authorship information.

=head1 COPYRIGHT & LICENSE

See L<CatalystX::Example::Todo> for rights information.

=cut


