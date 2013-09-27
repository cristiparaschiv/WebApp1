package WebApp::Helper;

use Dancer::Plugin::Database;

sub get_columns {
    my $self = shift;
    my $model = shift;
    
    if ($model eq 'artist') {
        return [
            {
                    field => 'name',
                    title => 'Artist',
                    width => 550
            },
            {
                    command => ['view'],
                    title => '',
                    width => 100
            }  
        ];
    } elsif ($model eq 'album') {
        return [
            {
                    field => 'name',
                    title => 'Album',
                    width => 550
            },
            {
                    command => ['view'],
                    title => '',
                    width => 100
            }  
        ];
    } elsif ($model eq 'track') {
        return [
            {
                field   => 'name',
                title => 'Track Name',
                width => 550,
            },
            {
                command => ['view'],
                title => '',
                width => 100
            }
        ];
    } elsif ($model eq 'genre') {
        return [
            {
                field => 'name',
                title => 'Genre',
                width => 550,
            },
            {
                command => ['view'],
                title => '',
                width => 100
            }
        ];
    }
    
}

1;