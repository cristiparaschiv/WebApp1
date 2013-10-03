package WebApp::Helper;

use Dancer;
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
                    width => 150
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
                    width => 150
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
                width => 150
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
                width => 150
            }
        ];
    }
    
}

sub parse_date {
    my $self = shift;
	my $date = shift;
	
	my @values = split('/', $date);
	my $month = $values[0];
	my $day = $values[1];
	my $year = $values[2];
	
	return "$year-$month-$day"; # Will be changed when moving from TIMESTAMP to DATE
}

sub db_to_date {
    my $self = shift;
    my $date = shift;
    
    $date =~ m/(\d+)-(\d+)-(\d+)/;
    
    return "$2/$3/$1";
}

sub parse_bio {
    my $self = shift;
    my $bio = shift;
    
    $bio =~ s/</&lt;/g;
    $bio =~ s/>/&gt;/g;
    $bio =~ s/"/&quot;/g;
    $bio =~ s/'/&#39;/g;
    $bio =~ s/\//&#x2F;/g;
    
    return $bio;
}

1;