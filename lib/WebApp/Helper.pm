package WebApp::Helper;

use Dancer::Plugin::Database;

sub get_columns {
    my $self = shift;
    my $model = shift;
    
    if ($model eq 'artists') {
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
    } elsif ($model eq 'albums') {
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
    } elsif ($model eq 'tracks') {
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
    } elsif ($model eq 'genres') {
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

sub get_metadata {
    my $self = shift;
    my $model = shift;
    my $values = shift;
    
    if ($model eq 'artist') {
        return artist_metadata($values);
    } elsif ($model eq 'album') {
        return album_metadata($values);
    } elsif ($model eq 'track') {
        return track_metadata($values);
    } elsif ($model eq 'genre') {
        return genre_metadata($values);
    }
    
}

sub artist_metadata {
    my $values = shift;
    my $metadata = [
        {
                name => 'name',
                display => 'Artist',
                type => 'string',
                options => {},
                value => $values->{name} // '',
                model => 'artist'
        },
        {
                name => 'description',
                display => 'Biography',
                type => 'text',
                options => {},
                value => $values->{description} // '',
                model => 'artist'
        },
        {
                name => 'picture',
                display => 'Picture',
                type => 'string',
                model => 'artist',
                options => {},
                value => $values->{picture} // '',
        },
        {
                name => 'country',
                display => 'Country',
                type => 'string',
                model => 'artist',
                options => {},
                value => $values->{country} // '',
        }
    ];
    return $metadata;
}

sub album_metadata {
    my $values = shift;
    my $metadata = [
        {
            name => 'artistid',
            display => 'Artist',
            type => 'select',
            options => get_option_hash('artist'),,
            value => $values->{artistid},
            model => 'album'
        },
        {
            name => 'name',
            display => 'Name',
            type => 'string',
            options => {},
            value => $values->{name},
            model => 'album',
        },
        {
            name => 'release_date',
            display => 'Release Date',
            type => 'string',
            options => {},
            value => $values->{release_date},
            model => 'album'
        },
        {
            name => 'genreid',
            display => 'Genre',
            type => 'select',
            options => get_option_hash('genre'),
            value => $values->{genreid},
            model => 'album'
        }
    ];
    return $metadata;
}

sub track_metadata {
    my $values = shift;
    my $metadata = [
        {
            name => 'albumid',
            display => 'Album',
            type => 'select',
            options => get_option_hash('album'),
            value => $values->{albumid},
            model => 'track'
        },
        {
            name => 'name',
            display => 'Track Name',
            type =>'string',
            options => {},
            value => $values->{name},
            model => 'track'
        }
    ];
    return $metadata;
}

sub genre_metadata {
    my $values = shift;
    my $metadata = [
        {
            name => 'name',
            display => 'Genre',
            type => 'string',
            options => {},
            value => $values->{name},
            model => 'genre',
        },
        {
            name => 'description',
            display => 'Description',
            type => 'text',
            options => {},
            value => $values->{description},
            model => 'genre'
        }
    ];
    return $metadata;
}

sub get_option_hash {
    my $model = shift;
    my $hash = {};
    
    my @records = database->quick_select($model . 's', {});
    foreach my $record (@records) {
        $hash->{$record->{id}} = $record->{name};
    }
    return $hash;
}

1;