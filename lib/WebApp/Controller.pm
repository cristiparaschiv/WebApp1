package WebApp::Controller;

use Dancer;
use Dancer::Plugin::Database;
use Dancer::Request::Upload;
use Data::Dumper;
use WebApp::Helper;
use WebApp::UI::Grid;
use WebApp::UI::Form;
use WebApp::Model;
use WebApp::UI::TabStrip;
use WebApp::Controller::Artist;
use WebApp::Controller::Album;
use WebApp::Controller::Track;
use WebApp::Controller::Genre;

use Cwd qw/realpath/;
use FindBin;


our $handlers = {
	'artist' => 'WebApp::Controller::Artist',
	'album' => 'WebApp::Controller::Album',
	'track' => 'WebApp::Controller::Track',
	'genre' => 'WebApp::Controller::Genre',
};

sub handle_request {
	my $method	= shift;
	my $params	= shift;
	my $model	= shift;
	my $action	= shift;
	my $id		= shift;
	
	my $handler = $handlers->{$model};
	
	#handle biography actions (non-model)
	if ($model eq 'biography') {
		if ($action eq 'edit') {
			return edit($id, $model);
		} elsif ($action eq 'add' and $method eq 'POST') {
			return submit_biography($params);
		}
	}
	
	if ($action eq 'view') {
		return (defined $id) ? $handler->view_details($id) : list_model($model);
	} elsif ($action eq 'edit') {
		return (defined $id) ? edit($id, $model) : return (template 'not_found');
	} elsif ($action eq 'delete') {
		return (defined $id) ? &delete($id, $model) : return (template 'not_found');
	} elsif ($action eq 'add' and $method eq 'GET') {
		return add($model);
	} elsif ($action eq 'add' and $method eq 'POST') {
		return submit($model, $params);
	} elsif ($action eq 'upload' and $method eq 'POST') {
		return upload($model, $params);
	}
	
}

sub submit_biography {
	my $params = shift;

	my $lib = 'WebApp::Model::Artist';
	my $instance = $lib->_get($params->{id});
	my $values = $instance->{values};
	$values->{description} = $params->{bio_value};
	$lib->_update($values, $params->{id});
	
	redirect '/artist/view/' . $params->{id};
}

sub submit {
	my $model = shift;
	my $params = shift;

	my $object = {};
	my $lib = 'WebApp::Model::' . ucfirst($model);
	my $metadata = $lib->_metadata();

	foreach my $field (@$metadata) {
		if ($field->{type} eq 'date' and $params->{"$model.$field->{name}"} ne '') {
			$params->{"$model.$field->{name}"} = WebApp::Helper->parse_date($params->{"$model.$field->{name}"});
		}
		if ($field->{type} eq 'boolean' and defined $params->{"$model.$field->{name}"}) {
			$params->{"$model.$field->{name}"} = 1;
		} elsif ($field->{type} eq 'boolean' and !defined $params->{"$model.$field->{name}"}) {
			$params->{"$model.$field->{name}"} = 0;
		}
		$object->{$field->{name}} = $params->{"$model.$field->{name}"};
	}

	if (defined $params->{id} and $params->{id} ne '') {
		$lib->_update($object, $params->{id});
	} else {
		$lib->_add($object);
	}	
	redirect '/' . $model . '/view';
}

sub add {
	my $model = shift;

	my $lib = 'WebApp::Model::' . ucfirst($model);
	my $action = '/' . $model . '/add';
	my $metadata = $lib->_metadata();	
	my $form = new WebApp::UI::Form($model, $metadata, $action);
        
    template 'add', {form => $form};
}

sub edit {
	my $id = shift;
	my $model = shift;
	
	if ($model eq 'biography') {
		my $lib = 'WebApp::Model::Artist';
		my $instance = $lib->_get($id);
		my $bio = $instance->{values}->{description};
		my $action = '/biography/add?id=' . $id;

		$bio = WebApp::Helper->parse_bio($bio);

		template 'bio_edit', {bio => $bio, action => $action};
	} else {
		my $lib = 'WebApp::Model::' . ucfirst($model);
		my $action = '/' . $model . '/add?id=' . $id;
		my $instance = $lib->_get($id);
		my $metadata = $lib->_metadata($instance->{values});
		my $form = new WebApp::UI::Form($model, $metadata, $action);

		template 'add', {form => $form};
	}
}

sub delete {
	my $id = shift;
	my $model = shift;
	
	my $lib = 'WebApp::Model::' . ucfirst($model);
	$lib->_delete($id);
	
	redirect '/' . $model . '/view';
}

sub upload {
	my $model = shift;
	my $params = shift;
	
    my $appdir = realpath("$FindBin::Bin/..");
	
	if ($model eq 'artist') {
		my $upload = $params->{uploads}->{'artist.picture.upload'};
		my $path = $appdir . '/public/images/artists/' . $upload->filename;
		$upload->copy_to($path);
	} elsif ($model eq 'album') {
		my $upload = $params->{uploads}->{'album.picture.upload'};
		my $path = $appdir . '/public/images/covers/' . $upload->filename;
		$upload->copy_to($path);
	}
		
	return 1;
}

sub list_model {
	my $model = shift;
	my $lib = 'WebApp::Model::' . ucfirst($model);
	
	my $records = $lib->_get_all();
	my $ds = [];
	
	foreach my $record (@$records) {
		push @$ds, {
			id => $record->{id},
			name => $record->{name},
		};
	}
	
	my $columns = WebApp::Helper->get_columns($model);
	
	if (session('user') eq 'cristi') {
		my $commands = $columns->[1]->{command};
		push @$commands, 'edit';
	}
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

sub browse_objects {
	my $self = shift;
	my $data = shift;
	my $model = shift;
	
	my $columns = [
		{
			field => 'name',
			title => 'Title',
			width => 400,
		},
		{
			command => ['view'],
			title => '',
			width => 100,
		}
	];
	
	my $grid = new WebApp::UI::Grid({
		datasource => {
			data => $data,
			pageSize => 10,
		},
		columns => $columns,
		dom_id => $model . 'Grid',
		width => '700px',
		opts => {
			selectable => 'true',
			sortable => 'false',
			filter => 'false',
		}
	});
	
	return (template 'view', {test => $grid, model => $model}, {layout => undef});
}

1;