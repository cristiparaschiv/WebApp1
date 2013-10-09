package WebApp::Model::Tool;

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
         menuname => {
            name => 'menuname',
            display => 'Menu Name',
            type => 'string',
            value => '',
            options => {},
            model => 'tool'
         },
         path => {
            name => 'path',
            display => 'Path',
            type => 'string',
            value => '',
            options => {},
            model => 'tool'
         },
         controller => {
            name => 'controller',
            display => 'Controller',
            type => 'string',
            value => '',
            options => {},
            model => 'tool',
         },
		 action => {
			name => 'action',
			display => 'Action',
			type => 'string',
			value => '',
			options => {},
			model => 'tool',
		 },
		 order => {
			name => 'order',
			display => 'Order',
			type => 'string',
			value => '',
			options => {},
			model => 'tool',
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