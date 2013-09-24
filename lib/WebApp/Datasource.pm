package WebApp::Datasource;
use JSON;
use Dancer ':syntax';

sub init {
	my $self = shift;
	my $data = shift;
	my $opts = shift;
use Data::Dumper; debug Dumper $data;	

	
	
	if (ref $data eq 'ARRAY') {
		foreach my $item (@$data) {
			foreach my $elem (keys %$item) {
				
			}
		}
	} elsif (ref $data eq 'HASH') {
	
	} else {
		return {};
	}
	
	return to_json({
		data => $data,
		pageSize => $opts->{pageSize} // 10,
	});
}

1;