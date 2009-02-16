#!perl

use strict;
use warnings;

use Test::More tests => 1;

use Acme::CPANAuthors;

my $authors = eval { Acme::CPANAuthors->new("You're_using") };

SKIP: {
 skip $@ => 1 unless defined $authors;

 my $count = $authors->count;
 diag "$count authors found";
 cmp_ok $count, '>', 0, 'there are some authors';
}
