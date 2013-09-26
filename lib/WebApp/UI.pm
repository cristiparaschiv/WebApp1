package WebApp::UI;

use Template;
use Data::Dumper;
use Dancer ':syntax';

use Cwd;

sub new {
	
	my $self = shift;
	my $data = shift;
	
	my $datasource = $data->{datasource};
	my $columns = $data->{columns};
	
	my $grid = {
		datasource => to_json($datasource),
		columns => to_json($columns),
	};
	
	my $template = Template->new({
		INCLUDE_PATH => '../../views',
		EVAL_PERL => 1
	});

	return (template 'grid', {grid => $grid}, {layout => undef});
}

1;