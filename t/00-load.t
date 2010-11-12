#!perl

use Test::More tests => 3;

use lib './lib';

BEGIN {
    use_ok( 'WWW::PhyloBox' );
    use_ok( 'WWW::PhyloBox::Response' );
    require_ok( 'WWW/PhyloBox/Manual.pod' );
}

diag( "Testing WWW::PhyloBox Perl $], $^X" );
