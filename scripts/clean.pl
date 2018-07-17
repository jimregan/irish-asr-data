#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

while(<STDIN>) {
    chomp;
    s/\./ /g;
    s/“/ /g;
    s/,/ /g;
    s/”/ /g;
    s/!/ /g;
    s/\?/ /g;
    s/\[/ /g;
    s/\]/ /g;
    s/\(/ /g;
    s/\)/ /g;
    s/—/ /g;
    s/;/ /g;

    s/’/'/g;

    s/  */ /g;

    for my $word (split/ /) {
        my $lcword = irishlc($word);
        print "$lcword ";
    }
    print "\n";
}

sub irishlc {
    my $word = shift;
    $word =~ s/([nt])([AEIOUÁÉÍÓÚ])/$1-$2/;
    return lc($word);
}
