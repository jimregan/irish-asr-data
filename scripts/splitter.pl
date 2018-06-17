#!/usr/bin/perl
# This module was created before I added support for Irish to moses's tokeniser
# add https://raw.githubusercontent.com/moses-smt/mosesdecoder/master/scripts/share/nonbreaking_prefixes/nonbreaking_prefix.ga
# to the module's share directory

use warnings;
use strict;
use utf8;

use Lingua::Sentence;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

my $splitter = Lingua::Sentence->new("ga");

while(<>) {
	chomp;
	s/\r//;
	s/„//g;
	next if(/^$/);
	my $firstpass = $splitter->split($_);
	print "$firstpass\n";
}

