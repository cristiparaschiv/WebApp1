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