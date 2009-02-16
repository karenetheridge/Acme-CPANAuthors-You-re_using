use strict;
use warnings;
use ExtUtils::MakeMaker;

my $dist = 'Acme-CPANAuthors-You-re_using';

my %META = (
 configure_requires => {
  'ExtUtils::MakeMaker' => 0,
 },
 build_requires => {
  'Acme::CPANAuthors'   => 0,
  'ExtUtils::MakeMaker' => 0,
  'Test::More'          => 0,
 },
 resources => {
  bugtracker => "http://rt.cpan.org/NoAuth/ReportBug.html?Queue=$dist",
  homepage   => "http://search.cpan.org/dist/$dist/",
  license    => 'http://dev.perl.org/licenses/',
  repository => "http://git.profvince.com/perl/modules/$dist.git",
 },
);

WriteMakefile(
    NAME             => 'Acme::CPANAuthors::You::re_using',
    AUTHOR           => 'Vincent Pit <perl@profvince.com>',
    LICENSE          => 'perl',
    VERSION_FROM     => 'lib/Acme/CPANAuthors/You/re_using.pm',
    ABSTRACT_FROM    => 'lib/Acme/CPANAuthors/You/re_using.pm',
    PL_FILES         => {},
    PREREQ_PM        => {
        'Acme::CPANAuthors'   => 0,
        'Carp'                => 0,
        'ExtUtils::Installed' => 0,
    },
    MIN_PERL_VERSION => 5.006,
    META_MERGE       => \%META,
    dist             => {
        PREOP    => 'pod2text lib/Acme/CPANAuthors/You/re_using.pm > $(DISTVNAME)/README',
        COMPRESS => 'gzip -9f', SUFFIX => 'gz'
    },
    clean            => {
        FILES => "$dist-* *.gcov *.gcda *.gcno cover_db Debian_CPANTS.txt"
    },
);
