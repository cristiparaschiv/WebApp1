package WebApp::Model;

use WebApp::Model::Artist;
use WebApp::Model::Album;
use WebApp::Model::Track;
use WebApp::Model::Genre;
use WebApp::Model::Picture;
use WebApp::Model::Tool;
use WebApp::Helper;
use Dancer;
use Dancer::Plugin::Database;
use Tie::IxHash;


our $tables = {
    'WebApp::Model::Artist' => 'artists',
    'WebApp::Model::Album' => 'albums',
    'WebApp::Model::Track' => 'tracks',
    'WebApp::Model::Genre' => 'genres',
	'WebApp::Model::Tool' => 'tools',
	'WebApp::Model::Picture' => 'pictures',
};

sub _metadata {
    my $lib = shift;
    my $values = shift;
    my $model = new $lib();  
    my $metadata = [];
    my $fields = $model->_fields();
    
    foreach my $field (keys %{$fields->{_fields}}) {
        $fields->{_fields}->{$field}->{value} = $values->{$field} // '';
		if ($fields->{_fields}->{$field}->{type} eq 'date' and defined $values->{$field}) {
			my $formated_date = WebApp::Helper->db_to_date($values->{$field});
			$fields->{_fields}->{$field}->{value} = $formated_date;
		}
        push @$metadata, $fields->{_fields}->{$field};
    }
    #debug to_dumper $metadata;

    return $metadata;
}

sub _get {
    my $lib = shift;
    my $id = shift;
    
    my $table = $tables->{$lib};
    my $instance = database->quick_select($table, { id => $id });
    
    return {
        values => $instance,
    };
}

sub _get_all {
    my $lib = shift;
	my $clause = shift // {};
    my $table = $tables->{$lib};
    
    my @instances = database->quick_select($table, $clause);
    return \@instances;
}

sub _add {
    my $lib = shift;
    my $object = shift;
    
    my $table = $tables->{$lib};
    database->quick_insert($table, $object);
    debug "[Model] Adding object $lib to table $table.";
}

sub _update {
    my $lib = shift;
    my $object = shift;
    my $id = shift;
    
    my $table = $tables->{$lib};
    database->quick_update($table, { id => $id }, $object);
    debug "[Model] Updating object $lib with id $id.";
}

sub _delete {
    my $lib = shift;
    my $id = shift;
    
    my $table = $tables->{$lib};
    database->quick_delete($table, { id => $id });
    debug "[Model] Deleted model $lib with id $id from table $table.";
}

sub get_option_hash {
    my $lib = shift;
    my $hash = {};
    
    my $instances = $lib->_get_all();
    
    foreach my $record (@$instances) {
        $hash->{$record->{id}} = $record->{name};
    }
    
    tie (my %h, 'Tie::IxHash');
    foreach ( sort {$hash->{$a} cmp $hash->{$b}} keys %$hash) {
        $h{$_} = $hash->{$_};
    }
    
    return \%h;
}


1;