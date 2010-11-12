use Test::Most;
use WWW::PhyloBox;
use File::Slurp qw/slurp/;

plan( tests => 3 );

my $phylobox = WWW::PhyloBox->new;
my $newick   = slurp("t/data/foo.newick");

isa_ok($phylobox, 'WWW::PhyloBox');

{
    lives_ok {
        $phylobox->create(
            phyloFile => $newick,
            response  => "key",
        )
    } 'creating newick';
    isa_ok($response, 'WWW::PhyloBox::Response');
}
