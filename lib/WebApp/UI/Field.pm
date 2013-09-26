package WebApp::UI::Field;

use Dancer;

sub new {
    my $self = shift;
    my $field_data = shift;
    
    #my $field_name = $field_data->{name};
    #my $field_label = $field_data->{display};
    #my $field_type = $field_data->{type};
    #my $field_options = $field_data->{options};
    
    return (template 'ui/field', {field => $field_data}, {layout => undef});
}

1;