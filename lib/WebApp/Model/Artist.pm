package WebApp::Model::Artist;

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
            display => 'Artist',
            type => 'string',
            value => '',
            options => {},
            model => 'artist',
        },
        description => {
            name => 'description',
            display => 'Biography',
            type => 'text',
            value => '',
            options => {},
            model => 'artist',
        },
        picture => {
            name => 'picture',
            display => 'Picture',
            type => 'string',
            value => '',
            options => {},
            model => 'artist',
        },
        country => {
            name => 'country',
            display => 'Country',
            type => 'string',
            value => '',
            options => {},
            model => 'artist',
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