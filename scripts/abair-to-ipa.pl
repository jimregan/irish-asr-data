#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use FindBin qw($RealBin);

open(MAP, '<', "$RealBin/mappings/abair-map.tsv");
binmode(MAP, ":utf8");
binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

my %map = ();

while(<MAP>) {
    chomp;
    s/\r//g;
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
    $map{"\N{U+02C8}"} = "\N{U+02C8}";
    $map{"\N{U+02CC}"} = "\N{U+02CC}";
    $map{"SILENCE_TOKEN"} = '';
    $map{"sil"} = '';
    $map{'GLOTTAL_STOP'} = "\N{U+0294}";
}

while(<>) {
    chomp;
    my ($lem, $pron) = split/\t/;
    next if(!$pron);
    next if($lem eq 'GLOTTAL_STOP');
    next if($lem eq 'SILENCE_TOKEN');
    my @phones = split/ /, $pron;
    my @ophones = map { $map{$_} } @phones;
    my $right = join(" ", @ophones);
    $right =~ s/  +/ /g;
    next if($right eq '' && $lem =~ /^\p{Punct}+$/);
    print "$lem\t$right\n";
}
