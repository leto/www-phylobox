package WWW::PhyloBox;

use Moose;
use LWP::UserAgent;
use Data::Dumper;

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
    my $phylobox = WWW::PhyloBox->new;
    $phylobox->create(
        phyloUrl => "http://example.com/phylo.xml",
        response  => "key",
    );

=head1 ABSTRACT

PhyloBox is an online environment for viewing, editing, sharing, and publishing
phylogenetic trees. The preferred data format for importing phylogenetic trees
is PhyloXML, but the Newick format is also marginally supported.

=head1 LINKS

http://phylobox.appspot.com

https://github.com/andrewxhill/PhyloBox/wiki

=cut


sub create {
    my ($self, %args) = @_;
    my $response = $self->ua->post(
        $self->base_url . "/new",
        \%args,
    );
    warn Dumper [ $response ];
}

1;
