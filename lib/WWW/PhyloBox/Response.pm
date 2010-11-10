package WWW::PhyloBox::Response;

use Moose;
use Data::Dumper;
use JSON::Any;

# perhaps this needs a better name
has json => (
    isa => 'HashRef',
    is  => 'rw',
);

1;
