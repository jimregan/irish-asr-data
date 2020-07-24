#!/usr/bin/perl

use warnings;
use strict;
use utf8;
use Getopt::Std;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

open(MAP, '<', 'phone-map.tsv');
binmode(MAP, ":utf8");

our($opt_a);
getopts('a');
my %map = ();
while(<MAP>) {
	chomp;
	my @p = split/\t/, $_;
	if($opt_a) {
		$map{$p[0]} = $p[1];
	} else {
		$map{$p[0]} = $p[2];
	}
}
close(MAP);

while(<STDIN>) {
	chomp;
	my @parts = split/\t/;
	my $word = $parts[0];
	$parts[1] =~ s/[012]//g;
	my @phones = split/ /, $parts[1];
	my @outp = map { $map{$_} } @phones;
	print "$word " . join(' ', @outp) . "\n";
}
