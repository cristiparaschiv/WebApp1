package WebApp::Controller::Album;

use Dancer;
use WebApp::Model;
use WebApp::Controller;

our @ISA = qw(WebApp::Controller);

sub view_details {
	my $self = shift;
	my $id = shift;

	my $instance = WebApp::Model::Album->_get($id);
	my $values = $instance->{values};
	
	my $artistid = $values->{artistid};
	my $name = $values->{name};
	my $release_date = $values->{release_date};
	my $picture = $values->{picture};
	my $genreid = $values->{genreid};

	my $artist = WebApp::Model::Artist->_get_all({id => $artistid});
	my $artist_name = $artist->[0]->{name};
	
	my $genre = WebApp::Model::Genre->_get_all({id => $genreid});
	my $genre_name = $genre->[0]->{name};
	
	my $params = {
		artist => $artist_name,
		name => $name,
		release_date => $release_date,
		genre => $genre_name,
		picture => $picture,
	};
	
	template 'album_details', {data => $params};
}

1;