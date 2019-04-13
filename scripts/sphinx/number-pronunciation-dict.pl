#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

my %seen = ();

while(<>) {
	chomp;
	my @parts = split/ /;
	my $word = shift @parts;
	if(exists $seen{$word}) {
		$seen{$word}++;
		print "$word($seen{$word}) " . join(" ", @parts) . "\n";
	} else {
		$seen{$word} = 1;
		print "$word " . join(" ", @parts) . "\n";
	}
}
