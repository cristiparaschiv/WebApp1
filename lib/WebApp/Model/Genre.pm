package WebApp::Model::Genre;

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
        name => {
            name => 'name',
            display => 'Name',
            type => 'string',
            value => '',
            options => {},
            model => 'genre',
        },
        description => {
            name => 'description',
            display => 'Description',
            type => 'text',
            value => '',
            options => {},
            model => 'genre',
        }
    );
    return \%fields;
}

sub _fields {
    my $self = shift;
    
    $self->{_fields} = &fields();
    return $self;
}

1;