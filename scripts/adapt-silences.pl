#!/usr/bin/perl
# Takes a finetuneas json file, and an audacity labels file
# generated by Audacity's sound finder

use warnings;
use strict;
use utf8;

use JSON;
use File::Slurp;
use Data::Dumper;

binmode(STDOUT, ":utf8");
my $fn = $ARGV[0];
my $silfn = $ARGV[1];

my $rawjson = read_file($fn);

open(SILS, '<', $silfn);
binmode(SILS, ":utf8");
my $idx = 0;
my %sils = ();
my %sile = ();
my @sils = ();
my $realstart = 0.0;
my $realend = 0.0;
while(<SILS>) {
	chomp;
	next if($_ !~ /\t/);
	my ($start, $end, $label) = split/\t/;
	if($start > 0.0) {
		$start = 0.0;
	}
	my %cursil = ('begin' => $start, 'end' => $end, 'label' => $label);
	push (@sils, \%cursil);
	$sils{$start} = $idx;
	$sile{$end} = $idx;
	if($realstart == 0.0 || $start < $realstart ) {
		$realstart = $start;
	}
	if($end > $realend) {
		$realend = $end;
	}
	$idx++;
}

sub max {
	my $base = 0.0;
	for my $num (@_) {
		if($num > $base) {
			$base = $num;
		}
	}
	$base;
}
sub min {
	my $base = shift;
	for my $num (@_) {
		if($num < $base) {
			$base = $num;
		}
	}
	$base;
}

sub overlap {
	my $a = shift;
	my $b = shift;
	my $begin = max($a->{'begin'}, $b->{'begin'});
	my $end = min($a->{'end'}, $b->{'end'});
	my $ol = $end - $begin;
	($ol < 0) ? 0 : $ol;
}

my $json = decode_json($rawjson);
if(exists $json->{'fragments'}) {
	for my $frag (@{$json->{'fragments'}}) {
		my $id = $frag->{'id'};

		if($frag->{'begin'} < $realstart) {
			$frag->{'begin'} = $realstart;
		}
		if($frag->{'end'} > $realend) {
			$frag->{'end'} = $realend;
		}

		my $begin = $frag->{'begin'};
		my $end = $frag->{'end'};

		# Brute force.
		# Could try to be smarter, starting from the last i
		# but this is cheap, so meh
		my $i = 0;
		while ($sils[$i]->{'end'} < $begin) {
			$i++;
		}
		my $j = $#sils;
		while ($sils[$j]->{'begin'} > $end) {
			$j--;
		}
		if($i == $j) {
			$frag->{'begin'} = $sils[$i]->{'begin'};
			$frag->{'end'} = $sils[$i]->{'end'};
		}
	}
}

print encode_json($json);