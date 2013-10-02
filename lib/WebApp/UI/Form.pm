package WebApp::UI::Form;

use Dancer;
use WebApp::UI::Field;

sub new {
    my $self = shift;
    my $model = shift;
    my $metadata = shift;
    my $action = shift;

    my $fields = [];
    
    foreach my $field_data (@$metadata) {
        my $field = new WebApp::UI::Field($field_data);
        push @$fields, $field;
    }
    
    my $form_data = {
        fields => $fields,
        model => $model,
        name => ucfirst($model), 
    };
    
    return (template 'ui/form', {form_data => $form_data, action => $action}, {layout => undef});
}

1;