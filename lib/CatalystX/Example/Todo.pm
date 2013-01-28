package CatalystX::Example::Todo;

use Pod::Markdown;

(caller() ? 1 : do {
  (my $parser = Pod::Markdown->new)
    ->parse_from_file(__FILE__);
  print $parser->as_markdown });

=head1 NAME

CatalystX::Example::Todo - Example TODO application

=head1 DESCRIPTION

This is a sample application designed to demo L<Catalyst>, L<DBIx::Class> and
related software.  It is designed for learning.

=head1 SEE ALSO

The following modules or resources may be of interest.

L<DBIx::Class>, L<Catalyst::Runtime>, L<Test::Most>

=head1 AUTHOR

    John Napiorkowski C<< <jjnapiork@cpan.org> >>

=head1 COPYRIGHT & LICENSE

    Copyright 2013, John Napiorkowski C<< <jjnapiork@cpan.org> >>

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

