package WebApp::Model::Track;

use Tie::IxHash;
use WebApp::Model;

our @ISA = qw(WebApp::Model);

sub new {
    my $class = shift;
    my $self = {};
    
    bless($self, $class);
    return $self;
}

sub fields {
    
    tie (my %fields, 'Tie::IxHash',
         albumid => {
            name => 'albumid',
            display => 'Album',
            type => 'select',
            value => '',
            options => WebApp::Model::Album->get_option_hash(),
            model => 'track',
         },
         name => {
            name => 'name',
            display => 'Name',
            type => 'string',
            value => '',
            options => {},
            model => 'track',
         },
		 artistid => {
			name => 'artistid',
			display => 'Artist',
			type => 'select',
			value => '',
			options => WebApp::Model::Artist->get_option_hash(),
			model => 'track',
		 },
		 playtime => {
			name => 'playtime',
			display => 'Play Time',
			type => 'string',
			value => '',
			options => {},
			model => 'track',
		 },
		 lyrics => {
			name => 'lyrics',
			display => 'Lyrics',
			type => 'text',
			value => '',
			options => {},
			model => 'track',
		 },
		 summary => {
			name => 'summary',
			display => 'Summary',
			type => 'text',
			value => '',
			options => {},
			model => 'track',
		 },
		 recommended => {
			name => 'recommended',
			display => 'Recommended',
			type => 'boolean',
			value => '',
			options => {},
			model => 'track',
		 },
    );
    return \%fields;
}

sub _fields {
    my $self = shift;
    
    $self->{_fields} = &fields();
    return $self;
}

1;