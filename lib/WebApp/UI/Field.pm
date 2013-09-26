package WebApp::UI::Field;

use Dancer;

sub new {
    my $self = shift;
    my $field_data = shift;
        
    return (template 'ui/field', {field => $field_data}, {layout => undef});
}

1;