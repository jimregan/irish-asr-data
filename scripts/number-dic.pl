#!/usr/bin/perl

# sort|uniq input!

use warnings;
use strict;
use utf8;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

my %seen = ();

while(<>) {
	chomp;
	my @parts = split/[ \t]/;
	my $l = shift @parts;
	my $r = join(" ", @parts);
	$l =~ s/\([0-9]+\)//;
	if(exists $seen{$l}) {
		print "$l($seen{$l}) $r\n";
		$seen{$l}++;
	} else {
		print "$l $r\n";
		$seen{$l} = 1;
	}
}
