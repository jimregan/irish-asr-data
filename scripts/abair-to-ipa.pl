#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use FindBin qw($RealBin);

open(MAP, '<', "$RealBin/abair-map.tsv");
binmode(MAP, ":utf8");
binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

my %map = ();

while(<MAP>) {
    chomp;
    next if(/^$/);
    next if(/^#/);
    my ($l, $r) = split/\t/;
    if(!defined $r) {
        die "unmapped entry: $l";
    }
    $map{$l} = $r;
    $map{'.'} = '';
    $map{'0'} = '';
    $map{'1'} = "\N{U+02C8}";
    $map{'2'} = "\N{U+02CC}";
}

while(<>) {
    chomp;
    my ($lem, $pron) = split/\t/;
    my @phones = split/ /, $pron;
    my @ophones = map { $map{$_} } @phones;
    my $right = join(" ", @ophones);
    $right =~ s/  +/ /g;
    print "$lem\t$right\n";
}