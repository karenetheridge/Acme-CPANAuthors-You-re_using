package Acme::CPANAuthors::You::re_using;

use strict;
use warnings;

use Carp qw/croak/;

use ExtUtils::Installed;

use Acme::CPANAuthors::Utils;

=head1 NAME

Acme::CPANAuthors::You::re_using - We are the CPAN authors that have written the modules installed on your perl!

=head1 VERSION

Version 0.01

=cut

our $VERSION;
BEGIN {
 $VERSION = '0.01';
}

=head1 SYNOPSIS

    use Acme::CPANAuthors;

    my $authors = Acme::CPANAuthors->new("You're_using");
    print $authors->name($_) . " ($_)\n" for $authors->id;

=head1 DESCRIPTION

This module builds an L<Acme::CPANAuthors> class by listing all the modules that are installed on the current C<perl> and then retrieving the name and the PAUSE id of their corresponding authors.

It may take some time to load since it has to search all the directory trees given by your C<@INC> for modules, but also to get and parse CPAN indexes.

=head1 FUNCTIONS

=head2 C<register>

Fetches and registers the names into L<Acme::CPANAuthors::Register>.
This function is automatically called when you C<use> this module, unless you have set the package variable C<$Acme::CPANAuthors::You're_using::SKIP> to true beforehand.

=cut

BEGIN { require Acme::CPANAuthors::Register; }

sub register {
 return if shift;

 my %authors;

 my $pkgs = Acme::CPANAuthors::Utils::cpan_packages();
 croak 'Couldn\'t retrieve a valid Parse::CPAN::Packages object' unless $pkgs;

 my $auths = Acme::CPANAuthors::Utils::cpan_authors();
 croak 'Couldn\'t retrieve a valid Parse::CPAN::Authors object' unless $auths;

 my $installed = ExtUtils::Installed->new(extra_libs => \@INC);
 croak 'Couldn\'t create a valid ExtUtils::Installed object' unless $installed;

 for ($installed->modules) {
  next unless defined and $_ ne 'Perl';

  my $mod = $pkgs->package($_);
  next unless $mod;

  my $dist = $mod->distribution;
  next unless $dist;

  my $cpanid = $dist->cpanid;
  next if not $cpanid or exists $authors{$cpanid};

  my $auth = $auths->author($cpanid);

  my $name;
  $name = $auth->name if defined $auth;
 
  $authors{$cpanid} = defined $name ? $name : $cpanid;
 }

 Acme::CPANAuthors::Register->import(%authors);
}

our $SKIP;

BEGIN { register($SKIP) }

=head1 DEPENDENCIES

L<Carp>, L<ExtUtils::Installed>, L<Acme::CPANAuthors>.

=head1 SEE ALSO

All others C<Acme::CPANAuthors::*> modules.

=head1 AUTHOR

Vincent Pit, C<< <perl at profvince.com> >>, L<http://www.profvince.com>.

You can contact me by mail or on C<irc.perl.org> (vincent).

=head1 BUGS

Please report any bugs or feature requests to C<bug-acme-cpanauthors-you-re_using at rt.cpan.org>, or through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Acme-CPANAuthors-You-re_using>.  I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Acme::CPANAuthors::You::re_using

=head1 COPYRIGHT & LICENSE

Copyright 2009 Vincent Pit, all rights reserved.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

1;
