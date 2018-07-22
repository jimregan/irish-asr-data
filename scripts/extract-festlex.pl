#!/usr/bin/perl

use warnings;
use strict;
use utf8;

while(<>) {
	chomp;
	if(/\(([^ ]*) nil \((.*)\)\)$/) {
		my $word = $1;
		my $prons = $2;

		my @parts = ();
		while($prons =~ /\(\(([^)]*)\)([012])\)/g) {
			my $phones = $1;
			my $stress = $2;
			$phones =~ s/^ //;
			$phones =~ s/ $//;
			push @parts, "$stress $phones";
		}
		print "$word\t" . join(' ', @parts) . "\n";
		
	}
}
