package WebApp::Model::Album;

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
         artistid => {
            name => 'artistit',
            display => 'Artist',
            type => 'select',
            value => '',
            options => WebApp::Model::Artist->get_option_hash(),
            model => 'album'
         },
         name => {
            name => 'name',
            display => 'Name',
            type => 'string',
            value => '',
            options => {},
            model => 'album'
         },
         release_date => {
            name => 'release_date',
            display => 'Release Date',
            type => 'string',
            value => '',
            options => {},
            model => 'album',
         },
         genreid => {
            name => 'genreid',
            display => 'Genre',
            type => 'select',
            value => '',
            options => WebApp::Model::Genre->get_option_hash(),
            model => 'album',
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