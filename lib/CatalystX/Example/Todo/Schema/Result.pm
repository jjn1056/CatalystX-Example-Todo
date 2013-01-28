package CatalystX::Example::Todo::Schema::Result;

use strict;
use warnings;
use base 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/
    Helper::Row::NumifyGet
    Helper::Row::OnColumnChange
    Helper::Row::ProxyResultSetMethod
    Helper::Row::ProxyResultSetUpdate
    Helper::Row::SelfResultSet
    Helper::Row::StorageValues
    Helper::Row::RelationshipDWIM
    InflateColumn::DateTime
  /);

sub default_result_namespace { 'CatalystX::Example::Todo::Schema::Result' }

1;

=head1 NAME

CatalystX::Example::Todo::Schema::Result - The base result class

=head1 SYNOPSIS

	package CatalystX::Example::Todo::Schema::Result::User;
    use parent 'CatalystX::Example::Todo::Schema::Result';
	
=head1 DESCRIPTION

All Result classes will inherit from this.  This provides some base functions,
primarily from included components.  Please see documentation for the following
components: L<DBIx::Class::Helpers>, L<DBIx::Class::InflateColumn::DateTime>.

=head1 ATTRIBUTES

This class defines the following attributes.

=head1 METHODS

This module defines the following methods.

=head2 default_result_namespace

Required by L<DBIx::Class::Helper::Row::RelationshipDWIM> to set the namespace
that gets prepended in relationships class names.

=head1 AUTHOR

See L<CatalystX::Example::Todo> for authorship information.

=head1 COPYRIGHT & LICENSE

See L<CatalystX::Example::Todo> for rights information.

=cut

