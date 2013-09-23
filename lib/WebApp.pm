package WebApp;
use Dancer ':syntax';
use Dancer::Plugin::SimpleCRUD;
use Dancer::Plugin::Database;


simple_crud(
	record_title => 'Genre',
	db_table => 'genres',
	prefix => '/genre',
	deletable => 'yes',
	sortable => 'yes',
	paginate => 5
);

simple_crud(
	record_title => 'Artist',
	db_table => 'artists',
	prefix => '/artist',
	deletable => 'yes',
	sortable => 'yes',
	paginable => 5
);

simple_crud(
	record_title => 'Albums',
	db_table => 'albums',
	prefix => '/album',
	deletable => 'yes',
	sortable => 'yes',
	paginable => 5,
	foreign_keys => {
		columnname => {
			table => 'artists',
			key_column => 'id',
			label_column => 'artistid',
		}
	}
);

simple_crud(
	record_title => 'Tracks',
	db_table => 'tracks',
	prefix => '/track',
	deletable => 'yes',
	sortable => 'yes',
	paginable => 5
);

set template => 'template_toolkit';

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

hook 'before' => sub {
	if (! session('user') && request->path_info !~ m{^/login}) {
		var requested_path => request->path_info;
		request->path_info('/login');
	}
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

get '/artist/view/:id' => sub {
	my $sth = database->prepare(
		'select * from artists where id = ?',
	);
	$sth->execute(params->{id});
	my $result = $sth->fetchrow_hashref;
	use Data::Dumper; debug Dumper $result;
	template 'artists', {name => $result->{name}, description => $result->{description} };
};

get '/artist/view' => sub {
	my $sth = database->prepare(
		'select * from artists',
	);
	$sth->execute();
	
	my $result;
	my $set = {};
	#while (%{$result} = $sth->fetchrow_hashref) {
		#$set->{$result->{id}} = {
			#name => $result->{name},
			#description => $result->{description},
			#id => $result->{id}
		#};
	#}
	my @result = database->quick_select('artists', {});
	use Data::Dumper; debug Dumper @result;
	template 'browse_artists', {result => \@result};
};

true;
