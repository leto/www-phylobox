use Test::Most;
use WWW::PhyloBox;
use Carp::Always;

use File::Slurp qw/slurp/;

plan( tests => 5 );

my $phylobox = WWW::PhyloBox->new;
my $phyloxml = slurp("t/data/test.xml");

{
    isa_ok($phylobox, 'WWW::PhyloBox');

    my $response;
    lives_ok {
        $response = $phylobox->create(
            phyloFile => $phyloxml,
            response  => "key",
        )
    };
    isa_ok($response, 'WWW::PhyloBox::Response');
}

{
    local $TODO = "PhyloBox does not support multiple phylogenies in one PhyloXML";
    my $phyloxml = slurp("t/data/phylo.xml");
    my $response;
    lives_ok {
        $response = $phylobox->create(
            phyloFile => $phyloxml,
            response  => "key",
        )
    }, 'creating phyloxml';
    isa_ok($response, 'WWW::PhyloBox::Response');
    # need to check return code
}
