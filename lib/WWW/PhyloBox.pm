package WWW::PhyloBox;

use Moose;
use LWP::UserAgent;
use Data::Dumper;
use JSON::Any;
use WWW::PhyloBox::Response;

has api_root => (
    isa     => 'Str',
    is      => 'rw',
    default => 'http://2-0.latest.phylobox.appspot.com',
);
has useragent_class => (
    isa     => 'Str',
    is      => 'ro',
    default => 'LWP::UserAgent',
);
has useragent_args  => ( isa => 'HashRef', is => 'ro', default => sub { {} } );

has json => (
    isa => 'JSON::Any',
    is  => 'ro',
    default => sub { JSON::Any->new },
);
sub BUILD {
    my ($self) = @_;
    $self->ua( LWP::UserAgent->new );
}

has ua => (
    isa => 'Object',
    is => 'rw'
);

# ABSTRACT: eats babies

=head1 NAME

WWW::PhyloBox - Perl interface to phylobox.appspot.com

=head1 SYNOPSIS

Please see WWW::PhyloBox::Manual for code examples.

=head1 ABSTRACT

PhyloBox is an online environment for viewing, editing, sharing, and publishing
phylogenetic trees. The preferred data format for importing phylogenetic trees
is PhyloXML, but the Newick format is also marginally supported.

=cut


sub create {
    my ($self, %args) = @_;
    my $response = $self->ua->post(
        $self->api_root . "/new",
        \%args,
    );
    my $json = $self->json->from_json( $response->content );
    return WWW::PhyloBox::Response->new( json => $json );
}

1;
