#!perl

use strict;
use warnings;

use Test::More;

use Acme::CPANAuthors;

my $authors = eval {
 local $SIG{__WARN__} = sub { die @_ };
 Acme::CPANAuthors->new("You're_using");
};

if ($authors) {
 plan tests => 5;
} else {
 plan skip_all => $@;
}

my $count = $authors->count;
diag "$count authors found";
cmp_ok $count, '>', 0, 'there are some authors';

is   $authors->name('???'),      undef,         'wrong name';
is   $authors->name('VPIT'),     'Vincent Pit', 'we should at least have this module';
isnt $authors->name('ISHIGAKI'), undef,         'we should at least have Acme::CPANAuthors\' author';
isnt $authors->name('LBROCARD'), undef,         'we should at least have Parse::CPAN::* author';
