package WebApp;
use Dancer ':syntax';
use Dancer::Plugin::SimpleCRUD;
use Dancer::Plugin::Database;
use WebApp::UI::Grid;
use WebApp::Datasource;
use WebApp::UI::Form;
use JSON;
use WebApp::Controller;

set template => 'template_toolkit';

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

# hook 'before' => sub {
	# if (! session('user') && request->path_info !~ m{^/login}) {
		# var requested_path => request->path_info;
		# request->path_info('/login');
	# }
# };

get '/login' => sub {
	template 'login', { path => vars->{requested_path} }, { layout=> undef };
};

get 'logout' => sub {
	session->destroy;
	set_flash('You are logged out.');
	request->path_info('/login');
};

post '/login' => sub {
	if (params->{username} eq 'cristi' && params->{password} eq 'pass') {
		session user => params->{username};
		redirect params->{path} || '/';
	} else {
		redirect '/login?failed=1';
	}
};

get '/admin' => sub {
		template 'admin'
};

get '/artist/:action/:id' => sub {
        my $action = params->{action};
        my $id = params->{id};
        
        return WebApp::Controller::handle_artist_id($action, $id);
};

get '/album/:action/:id' => sub {
		my $action = params->{action};
		my $id = params->{id};
		
		return WebApp::Controller::handle_album_id($action, $id);
};

get '/track/:action/:id' => sub {
	my $action = params->{action};
	my $id = params->{id};
	
	return WebApp::Controller::handle_track_id($action, $id);
};

get '/genre/:action/:id' => sub {
	my $action = params->{action};
	my $id = params->{id};
	
	return WebApp::Controller::handle_genre_id($action, $id);
};

any ['get', 'post'] => '/artist/:action' => sub {
	my $action = params->{action};
	my $params = {};
	$params = params;
	
	return WebApp::Controller::handle_artist(request->{method}, $action, $params);
};

any ['get', 'post'] =>  '/album/:action' => sub {
	my $action = params->{action};
	my $params = {};
	$params = params;
	
	return WebApp::Controller::handle_album(request->{method}, $action, $params);
};

any ['get', 'post'] => '/track/:action' => sub {
	my $action = params->{action};
	my $params = {};
	$params = params;
	
	return WebApp::Controller::handle_track(request->{method}, $action, $params);
};

any ['get', 'post'] => '/genre/:action' => sub {
	my $action = params->{action};
	my $params = {};
	$params = params;
	
	return WebApp::Controller::handle_genre(request->{method}, $action, $params);
};

get '/test' => sub {
	use WebApp::Model;
	
	my $meta = WebApp::Model::Artist->get_option_hash();
	debug to_dumper $meta;
	
	template 'test';
	
	#return 1;
};

true;
