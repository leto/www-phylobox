#!perl

use Test::More tests => 1;

use lib './lib';

BEGIN {
    use_ok( 'WWW::PhyloBox' );
}

diag( "Testing WWW::PhyloBox Perl $], $^X" );
