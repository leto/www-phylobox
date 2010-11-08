use Test::Most;
use WWW::PhyloBox;
use File::Slurp qw/slurp/;

plan( tests => 2 );

my $phylobox = WWW::PhyloBox->new;
my $newick   = slurp("t/data/foo.newick");

isa_ok($phylobox, 'WWW::Phylobox');

lives_ok {
    $phylobox->create(
        method   => "phyloxml",
        phyloxml => $newick,
    )
}, 'creating newick';

