package WebApp::Controller;

use Dancer;
use Dancer::Plugin::Database;
use Data::Dumper;
use WebApp::Helper;

sub handle_artist {
	my $method = shift;
	my $action = shift;
	my $params = shift;

	if ($action eq 'view') {
		list_model('artists'); #done
	} elsif ($action eq 'add' and $method eq 'GET') {
		add('artist'); #done
	} elsif ($action eq 'add' and $method eq 'POST') {
		submit('artist', $params); #done
	}	
}

sub handle_album {
	my $method = shift;
	my $action = shift;
	my $params = shift;
	
	if ($action eq 'view') {
		list_model('albums');#done
	} elsif ($action eq 'add' and $method eq 'GET') {
		add('album');#done
	} elsif ($action eq 'add' and $method eq 'POST') {
		submit('album', $params);
	}	
}

sub handle_track {
	my $method = shift;
	my $action = shift;
	my $params = shift;
	
	if ($action eq 'view') {
		list_model('tracks');#done
	} elsif ($action eq 'add' and $method eq 'GET') {
		add('track');#done
	} elsif ($action eq 'add' and $method eq 'POST') {
		submit('track', $params);
	}
}

sub handle_genre {
	my $method = shift;
	my $action = shift;
	my $params = shift;
	
	if ($action eq 'view') {
		list_model('genres');#done
	} elsif ($action eq 'add' and $method eq 'GET') {
		add('genre');#done
	} elsif ($action eq 'add' and $method eq 'POST') {
		submit('genre', $params);
	}
}

sub submit {
	my $model = shift;
	my $params = shift;
	
	my $object = {};
	my $metadata = WebApp::Helper->get_metadata($model);
	
	foreach my $field (@$metadata) {
		$object->{$field->{name}} = $params->{"$model.$field->{name}"};
	}
	
	debug '[Controller] Saving Artist object to database: ' . to_dumper($object);
	database->quick_insert($model . 's', $object);
	redirect '/' . $model . '/view';
}

sub add {
	my $model = shift;
	
	my $metadata = WebApp::Helper->get_metadata($model);
	my $form = new WebApp::UI::Form($model, $metadata, '/' . $model . '/add');
        
    template 'add', {form => $form};
}

sub list_model {
	my $model = shift;
	
	my @records = database->quick_select($model, {});
	my $ds = [];
	
	foreach my $record (@records) {
		push @$ds, {
			id => $record->{id},
			name => $record->{name},
		};
	}
	
	my $columns = WebApp::Helper->get_columns($model);
	my $grid = new WebApp::UI::Grid({
			datasource => {
					data => $ds,
					pageSize => 10,
			},
			columns => $columns,
			dom_id => $model . 'Grid',
			width => '1000px',
			opts => {
					selectable => 'true',
					sortable => 'false',
			}
	});
	
	template 'view', {test => $grid, model => $model};
}


sub handle_artist_id {
	my $action = shift;
	my $id = shift;

	if ($action eq 'view') {
		artist_view_details($id);
	}
	
}

sub handle_album_id {
	my $action = shift;
	my $id = shift;
	
	if ($action eq 'view') {
		album_view_details($id);
	}
	
}

sub handle_track_id {
	my $action = shift;
	my $id = shift;
	
	if ($action eq 'view') {
		track_view_details($id);
	}
	
}

sub handle_genre_id {
	my $action = shift;
	my $id = shift;
	
	if ($action eq 'view') {
		genre_view_details($id);
	}
	
}

sub artist_view_details {
	my $id = shift;
	my $record = database->quick_select('artists', { id => $id });
	
	my $name = $record->{name};
	my $description = $record->{description};
	my $picture = $record->{picture};
	
	my $params = {
		name => $name,
		bio => $description,
		picture => $picture,
	};
	
	template 'artist_details', {data => $params};
}

sub album_view_details {
	my $id = shift;
	my $record = database->quick_select('albums', { id => $id });
	
	my $artistid = $record->{artistid};
	my $name = $record->{name};
	my $release_date = $record->{release_date};
	my $genreid = $record->{genreid};
	
	my $artist = database->quick_select('artists', { id => $artistid });
	my $artist_name = $artist->{name};
	
	my $genre = database->quick_select('genres', { id => $genreid });
	my $genre_name = $genre->{name};
	
	my $params = {
		artist => $artist_name,
		name => $name,
		release_date => $release_date,
		genre => $genre_name,
	};
	
	template 'album_details', {data => $params};
}

sub track_view_details {
	my $id = shift;
	my $record = database->quick_select('tracks', { id => $id });
	
	my $albumid = $record->{albumid};
	my $name = $record->{name};
	
	my $album = database->quick_select('albums', { id => $id });
	my $album_name = $album->{name};
	
	my $params = {
		name => $name,
		album => $album_name,
	};
	
	template 'track_details', {data => $params};
}

sub genre_view_details {
	my $id = shift;
	my $record = database->quick_select('genres', { id => $id });
	
	my $name = $record->{name};
	my $description = $record->{description};
	
	my $params = {
		name => $name,
		description => $description,
	};
	
	template 'genre_details', {data => $params};
}


1;