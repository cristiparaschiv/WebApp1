package WebApp::UI::Grid;

use Template;
use Data::Dumper;
use Dancer ':syntax';

use Cwd;

sub new {
	
	my $self = shift;
	my $data = shift;
	
	my $datasource = $data->{datasource};
	my $columns = $data->{columns};
	my $dom_id = $data->{dom_id} // 'grid';
	my $width = $data->{width} // '500px';
	my $selectable = $data->{opts}->{selectable} // 'false';
	my $sortable = $data->{opts}->{sortable} // 'false';
	
	my $grid = {
		datasource => to_json($datasource),
		columns => to_json($columns),
		dom_id => $dom_id,
		width => $width,
		selectable => $selectable,
		sortable => $sortable,
	};
	
	my $template = Template->new({
		INCLUDE_PATH => '../../views',
		EVAL_PERL => 1
	});

	return (template 'ui/grid', {grid => $grid}, {layout => undef});
}

1;