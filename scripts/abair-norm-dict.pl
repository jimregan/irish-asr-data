#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use FindBin qw($RealBin);

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

my %norm = ();
open(NORM, "$RealBin/abair-simplify-map.tsv");
binmode(NORM, ":utf8");
while(<NORM>) {
    chomp;
    next if(/^#/);
    my ($a, $b) = split/\t/;
    $norm{$a} = $b;
}

while(<STDIN>) {
    chomp;
    my @parts = split/[ \t]/;
    my $word = shift @parts;
    my @out = map { local $_ = $_; if(exists $norm{$_}) {$norm{$_};} else {$_;} } @parts;
    print "$word " . join(" ", @out) . "\n";
}

