package CatalystX::Example::Todo::Schema::Result::TodoList;

use CatalystX::Example::Todo::Schema::Candy;

table 'todolist';

primary_column todolist_id => {
  data_type => "integer",
  is_auto_increment => 1};

column entry => {
  data_type => 'text'};

column status => {
  data_type => 'enum',
  default => 'open',
  extra => {list => [qw/open closed/]}};

1;

=head1 NAME

CatalystX::Example::Todo::Schema::Result::TodoList

=head1 DESCRIPTION

    TBD

=head1 METHODS

    TBD

=head1 AUTHOR

See L<CatalystX::Example::Todo> for authorship information.

=head1 COPYRIGHT & LICENSE

See L<CatalystX::Example::Todo> for rights information.

=cut
