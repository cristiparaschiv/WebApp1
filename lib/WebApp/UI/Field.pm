package WebApp::UI::Field;

use Dancer;

sub new {
    my $self = shift;
    my $field_data = shift;
    debug to_dumper $field_data;
    
    my $type = $field_data->{type};
    my $field_content;
    
    if ($type eq 'string' or $type eq 'number') {
        $field_content = parse_input($field_data);
    } elsif ($type eq 'select') {
        $field_content = parse_select($field_data);
    } elsif ($type eq 'text') {
        $field_content = parse_text($field_data);
    } elsif ($type eq 'date') {
        $field_content = parse_date($field_data);
    } elsif ($type eq 'boolean') {
	$field_content = parse_bool($field_data);
    } elsif ($type eq 'upload') {
	$field_content = parse_upload($field_data);
    }
    
    return (template 'ui/field', {field_content => $field_content, field => $field_data}, {layout => undef});
}

sub parse_input {
    my $field = shift;
    
    return (template 'ui/input', {field => $field}, {layout => undef});
    
}

sub parse_select {
    my $field = shift;
    
    return (template 'ui/select', {field => $field}, {layout => undef});
}

sub parse_text {
    my $field = shift;
    
    return (template 'ui/textarea', {field => $field}, {layout => undef});
}

sub parse_date {
    my $field = shift;
    
    return (template 'ui/date', {field => $field}, {layout => undef});    
}

sub parse_bool {
	my $field = shift;
	
	return (template 'ui/boolean', {field => $field}, {layout => undef});
}

sub parse_upload {
    my $field = shift;
    
    return (template 'ui/upload', {field => $field}, {layout => undef});
}

1;