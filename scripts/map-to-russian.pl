#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use FindBin qw($RealBin);

open(MAP, '<', "$RealBin/abair-to-russian.tsv") or die "$!";
binmode(MAP, ":utf8");
binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

my %map = ();

while(<MAP>) {
    chomp;
    my @l = split/\t/;
    $map{$l[1]} = $l[2];
}

sub mapper {
    my $phon = shift;
    if(!exists $map{$phon}) {
        print STDERR "No mapping found for $phon\n";
    } else {
        return $map{$phon};
    }
}

while(<>) {
    chomp;
    my @l = split/[ \t]/;
    my $word = shift @l;
    $word =~ s/\([0-9]+\)//;
    my @out = map { local $_ = $_; mapper($_) } @l;
    print "$word " . join(" ", @out) . "\n";
}
