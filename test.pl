use strict;
use warnings;
use CatalystX::Example::Todo::Web;
use Devel::Dwarn;

my $cntrl = CatalystX::Example::Todo::Web->controller("API");
my $action = $cntrl->action_for("add");
my $uri = CatalystX::Example::Todo::Web->uri_for_action($action);

Dwarn $uri;

