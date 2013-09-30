package WebApp::Controller::Artist;

use Dancer;
use WebApp::Model;
use WebApp::Controller;
use WebApp::UI::TabStrip;

our @ISA = qw(WebApp::Controller);

sub view_details {
	my $self = shift;
	my $id = shift;

	my $instance = WebApp::Model::Artist->_get($id);
	my $values = $instance->{values};
	
	my $name = $values->{name};
	my $description = $values->{description};
	my $picture = $values->{picture};

	my $params = {
		name => $name,
		bio => $description,
		picture => $picture,
		id => $id,
	};
	
	my $albums = WebApp::Model::Album->_get_all({
		artistid => $id
	});
	my $data = [];
	foreach my $album (@$albums) {
		push @$data, {
			id => $album->{id},
			name => $album->{name},
		};
	}
	my $discography_template = $self->browse_objects($data, 'album');
	my $tabstrip = new WebApp::UI::TabStrip({
		tabs => [
			'overview' => {
				text => 'Biography',
				content => (template 'artist_details_bio', {data => $params}, {layout => undef}),
			},
			'discography' => {
				text => 'Discography',
				content => $discography_template,
			},
		],
	});
	
	template 'artist_details', {content => $tabstrip};
}

1;