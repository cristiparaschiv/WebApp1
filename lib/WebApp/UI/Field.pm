package WebApp::UI::Field;

use Dancer;

sub new {
    my $self = shift;
    my $field_data = shift;
    debug to_dumper $field_data;    
    return (template 'ui/field', {field => $field_data}, {layout => undef});
}

1;