package WWW::PhyloBox;

use Moose;
use LWP::UserAgent;
use Data::Dumper;
use JSON::Any;
use WWW::PhyloBox::Response;

has base_url => (
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

    use WWW::PhyloBox;
    use File::Slurp qw/slurp/;

    my $phylobox = WWW::PhyloBox->new;

    # this creates a phylogenetic tree from a remote file
    my $tree1 = $phylobox->create(
        phyloUrl => "http://example.com/phylo.xml",
        response => "key",
        name     => "Moose speciation",
    );
    print $tree1->name . " tree is at " . $tree1->url . "\n";

    # read in PhyloXML to a string
    my $phyloxml = slurp("phylo.xml");

    # this creates a phylogenetic tree from string data
    my $tree2 = $phylobox->create(
        phyloFile => $phyloxml,
        response  => "key",
        name      => "T. Rex speciation",
    );

    print $tree2->name " has a key of " . $tree2->key . "\n";

=head1 ABSTRACT

PhyloBox is an online environment for viewing, editing, sharing, and publishing
phylogenetic trees. The preferred data format for importing phylogenetic trees
is PhyloXML, but the Newick format is also marginally supported.


=head1 ACKNOWLEDGEMENTS

This software was initially written at the GMOD Evolutionary Biology Hackathon
2010 at the National Evolutionary Synthesis Center (NESCent) in Durham, NC.

=head1 LINKS

http://phylobox.appspot.com

https://github.com/andrewxhill/PhyloBox/wiki

http://nescent.org

=cut


sub create {
    my ($self, %args) = @_;
    my $response = $self->ua->post(
        $self->base_url . "/new",
        \%args,
    );
    my $json = $self->json->from_json( $response->content );
    return WWW::PhyloBox::Response->new( json => $json );
}

1;
