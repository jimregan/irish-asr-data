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
    $map{"\N{U+02C8}"} = "\N{U+02C8}";
    $map{"\N{U+02CC}"} = "\N{U+02CC}";
    $map{"SILENCE_TOKEN"} = '';
    $map{"sil"} = '';
    $map{'GLOTTAL_STOP'} = "\N{U+0294}";
}

sub phmap {
    my $ph = shift;
    if(exists $map{$ph}) {
        return $map{$ph};
    } else {
        print STDERR "Missing mapping for phone: $ph\n";
    }
}

while(<>) {
    chomp;
    my @elems = split/ /;
    my $lem = shift @elems;
    my $pron = join(' ', @elems);
    next if(!$pron);
    next if($lem eq 'GLOTTAL_STOP');
    next if($lem eq 'SILENCE_TOKEN');
    my @phones = split/ /, $pron;
    my @ophones = map { $phmap($_) } @phones;
    if(!@ophones) {
      print STDERR "Error in line: $_\n";
    }
    my $right = join(" ", @ophones);
    $right =~ s/  +/ /g;
    next if($right eq '' && $lem =~ /^\p{Punct}+$/);
    print "$lem\t$right\n";
}
