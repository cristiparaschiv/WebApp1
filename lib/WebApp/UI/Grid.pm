package WebApp::UI::Grid;
use Dancer ':syntax';
use Dancer::Template::TemplateToolkit;

sub new {
	#my $class = shift;
	my $self = {};
	
	#bless($self, ref($class) || $class);
	
	my $datasource = [
		{
			name => 'Abc',
			age => 12,
		},
		{
			name => 'Qwe',
			age => 22,
		
		}
	];
	
	$self->{datasource} = $datasource;
	$self->{template} = $self->{template} || 'index.tt';
	
	#return $self;
	#my $t = Dancer::Template::MojoTemplate->init();
	#return $t->render($self->{template});
	my $t = Dancer::Template::TemplateToolkit->init();
	my $content = $t->render('index.tt');
	return (Dancer->template->render('index.tt'));
}

1;