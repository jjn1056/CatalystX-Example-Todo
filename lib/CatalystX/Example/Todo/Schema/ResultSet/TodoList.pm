package CatalystX::Example::Todo::Schema::ResultSet::TodoList;

use strictures;
use base 'CatalystX::Example::Todo::Schema::ResultSet';

sub all_todos { shift }

sub open_todos { shift->search({status=>'open'}) }

sub closed_todos { shift->search({status=>'closed'}) }

1;
