#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use JSON;
use File::Slurp;
use Data::Dumper;

binmode(STDOUT, ":utf8");
my $fn = $ARGV[0];

my $rawjson = read_file($fn);

my $json = decode_json($rawjson);
if(exists $json->{'fragments'}) {
	for my $frag (@{$json->{'fragments'}}) {
		my $id = $frag->{'id'};
		my $begin = $frag->{'begin'};
		my $end = $frag->{'end'};
#		printf "%s\t%.03f\t%.03f\t", $id, $begin, $end;
		printf "%.03f\t%.03f\t", $begin, $end;
		print join(" ", @{$frag->{'lines'}}) . "\n";
	}
}

