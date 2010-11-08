use Test::Most;
use WWW::PhyloBox;
use File::Slurp qw/slurp/;

plan( tests => 2 );

my $phylobox = WWW::PhyloBox->new;
my $phyloxml = slurp("t/data/phylo.xml");

isa_ok($phylobox, 'WWW::Phylobox');

lives_ok {
    $phylobox->create(
        method   => "phyloxml",
        phyloxml => $phyloxml,
    )
}, 'creating phyloxml';
