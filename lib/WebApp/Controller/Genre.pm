package WebApp::Controller::Genre;

use Dancer;
use WebApp::Model;
use WebApp::Controller;

our @ISA = qw(WebApp::Controller);

sub genre_view_details {
	my $self = shift;
	my $id = shift;
	
	my $instance = WebApp::Model::Genre->_get($id);
	my $values = $instance->{values};
	
	my $name = $values->{name};
	my $description = $values->{description};
	
	my $params = {
		name => $name,
		description => $description,
	};
	
	template 'genre_details', {data => $params};
}

1;