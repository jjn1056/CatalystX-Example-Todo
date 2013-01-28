package CatalystX::Example::Todo::Schema::DefaultRS;

use strictures;
use base 'CatalystX::Example::Todo::Schema::ResultSet';

1;

=head1 NAME

CatalystX::Example::Todo::Schema::DefaultRS - Use this as the default ResultSet.

=head1 DESCRIPTION

L<DBIx::Class> will use a resultset class which shares a name with the Result
class.  If one does not exist, use this class as the default.  Both custom and
default Resultsets share L<CatalystX::Example::Todo::Schema::ResultSet> as a
common base class.

If you are thinking of adding methods here, they probably belong in the true
base parent L<CatalystX::Example::Todo::Schema::ResultSet>.

=head1 AUTHOR

See L<CatalystX::Example::Todo> for authorship information.

=head1 COPYRIGHT & LICENSE

See L<CatalystX::Example::Todo> for rights information.

=cut

