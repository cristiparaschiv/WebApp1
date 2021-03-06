package WebApp;
use Dancer ':syntax';
use Dancer::Plugin::Database;
use Dancer::Request::Upload;
use JSON;
use WebApp::Controller;
use WebApp::Menu;

set template => 'template_toolkit';

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

hook 'before' => sub {
	session user => 'cristi'; # hardcoding for now user in session
	if (! session('user') && request->path_info !~ m{^/login}) {
		var requested_path => request->path_info;
		request->path_info('/login');
	}
	
	# Get megamenu
	my $menu = new WebApp::Menu;
	session megamenu => $menu;
};

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

# ---------- Experimental -----
any ['get', 'post'] => '/:model/:action' => sub {
	my $model	= params->{model};
	my $action	= params->{action};
	my $method  	= request->{method};
	my $params	= params;
	my $uploads 	= request->uploads // {};
	$params->{uploads} = $uploads;
	return WebApp::Controller::handle_request($method, $params, $model, $action);
};

any ['get', 'post'] => '/:model/:action/:id' => sub {
	my $model	= params->{model};
	my $action	= params->{action};
	my $id		= params->{id};
	my $method  	= request->{method};
	my $params	= params;
	my $uploads 	= request->uploads // {};
	$params->{uploads} = $uploads;
	return WebApp::Controller::handle_request($method, $params, $model, $action, $id);
};
# -----------------------------

get '/test' => sub {
	template 'menu';
};

true;
