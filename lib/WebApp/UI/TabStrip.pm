package WebApp::UI::TabStrip;

use Dancer;

sub new {
	my $self = shift;
	my $options = shift;
	
	return (template 'ui/tabstrip', {options => $options}, {layout => undef});
}

1;