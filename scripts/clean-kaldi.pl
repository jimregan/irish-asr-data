#!/usr/bin/perl

use warnings;
use strict;
use utf8;

my $filename;
if($ARGV[0]) {
	$filename = $ARGV[0];
} else {
	die "No input file specified!\n";
}

my @tmppath = split/\//, $filename;
my $fileonly = $tmppath[$#tmppath];

open(INPUT, '<', $filename);
open(OUTPUT, '>', "${filename}.clean");

binmode(INPUT, ":utf8");
binmode(OUTPUT, ":utf8");

my @rapos = ();
#my @rapos = qw/'tá 'á/;
my %apos = map { $_ => 1 } @rapos;

sub cleaner {
	my $word = shift;
	# surrounding apostrophes can be removed
	if(substr($word, 0, 1) eq "'" && substr($word, -1) eq "'") {
		$word = substr($word, 1, -1);
	}
	# apostrophe following punctuation can always be safely removed
	$word =~ s/[,;\!\?\.]+'$//;
	$word =~ s/[,;\!\?\.]+$//;
	if(!exists $apos{$word}) {
		$word =~ s/^'//;
		$word =~ s/'$//;
	}
	$word;
}

while(<INPUT>) {
	chomp;
	my @pieces = split/ /;
	my $first = shift @pieces;
	if($fileonly eq 'text') {
		my @out = map { cleaner($_) } @pieces;
		print OUTPUT "$first " . join(" ", @out) . "\n";
	} else {
		next if($first eq '');
		my $firstword = cleaner($first);
		print OUTPUT "$firstword " . join(" ", @pieces) . "\n";
	}
}
