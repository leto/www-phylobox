use Test::Most;
use WWW::PhyloBox;
use File::Slurp qw/slurp/;

use lib qw(t/lib);
#use Mock::LWP::UserAgent;

plan( tests => 2 );

my $phylobox = WWW::PhyloBox->new;
my $newick   = slurp("t/data/foo.newick");

isa_ok($phylobox, 'WWW::PhyloBox');

lives_ok {
    $phylobox->create(
        method    => "newick",
        phyloFile => $newick,
        response  => "key",
    )
}, 'creating newick';

