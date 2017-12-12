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
	my ($l, $r) = split/\t/;
	next if($r eq '');
	$l =~ s/\([0-9]+\)//;
	if(exists $seen{$l}) {
		print "$l($seen{$l})\t$r\n";
		$seen{$l}++;
	} else {
		print "$_\n";
		$seen{$l} = 1;
	}
}
