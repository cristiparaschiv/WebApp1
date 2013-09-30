package WebApp::Controller::Track;

use Dancer;
use WebApp::Model;
use WebApp::Controller;

our @ISA = qw(WebApp::Controller);

sub view_details {
	my $self = shift;
	my $id = shift;
	
	my $instance = WebApp::Model::Track->_get($id);
	my $values = $instance->{values};
	
	my $albumid = $values->{albumid};
	my $name = $values->{name};
	
	my $album = WebApp::Model::Album->_get_all({id => $id});
	my $album_name = $album->[0]->{name};
	
	my $params = {
		name => $name,
		album => $album_name,
	};
	
	template 'track_details', {data => $params};
}

1;