use Test::Most;
use WWW::PhyloBox;

use File::Slurp qw/slurp/;

plan( tests => 3 );

my $phylobox = WWW::PhyloBox->new;
my $phyloxml = slurp("t/data/test.xml");

{
    isa_ok($phylobox, 'WWW::PhyloBox');

    lives_ok {
        $phylobox->create(
            method    => "phyloxml",
            phyloFile => $phyloxml,
            response  => "key",
        )
    }, 'creating phyloxml';
}

{
    my $phyloxml = slurp("t/data/phylo.xml");
    lives_ok {
        $phylobox->create(
            method    => "phyloxml",
            phyloFile => $phyloxml,
            response  => "key",
        )
    }, 'creating phyloxml';
    # need to check return code
}
