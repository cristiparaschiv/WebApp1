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
    };
    
    return (template 'ui/form', {form_data => $form_data, action => $action}, {layout => undef});
}

#[
#    {
#        name => 'name',
#        display => 'Artist',
#        type => 'string',
#        options => {
#            1 => 'text1',
#            2 => 'text2',
#        },
#        model => 'artist'
#    },
#    {
#        name => 'description',
#        display => 'Biography',
#        type => 'text',
#        options => {},
#        model => 'artist'
#    }
#]

1;