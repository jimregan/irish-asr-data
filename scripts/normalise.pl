#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use FindBin qw($RealBin);

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

#my %norm = (
#    "dh'fheisgint" => "d'fheiscint",
#    "dtineóntaidhe" => "dtionóntaí",
#    'lastiar' => 'laistiar',
#    'sheasuigheadh' => 'sheasadh',
#    "tineóntaithe" => "tionóntaí",
#    "Maghchromtha" => "Maigh Chromtha",
#);

my %norm = ();
open(NORM, "$RealBin/normalisations.wiki");
binmode(NORM, ":utf8");
while(<NORM>) {
    chomp;
    next unless(/^\*/);
    s/^\* //;
    s/\/\/.*$//;
    my ($a, $b) = split/: /;
    $norm{$a} = $b;
}

while(<STDIN>) {
    chomp;
    s/\./ ./g;
    s/“/“ /g;
    s/,/ ,/g;
    s/”/ ”/g;
    s/!/ !/g;
    s/\?/ ?/g;

#    s/’/'/g;

    for my $word (split/ /) {
        my $lcword = irishlc($word);
        if (exists $norm{$word}) {
            print $norm{$word} . " ";
        } elsif (exists $norm{$lcword}) {
            print $norm{$lcword} . " ";
        } else {
            print "$lcword ";
        }
    }
    print "\n";
}

sub irishlc {
    my $word = shift;
    $word =~ s/([nt])([AEIOUÁÉÍÓÚ])/$1-$2/;
    return lc($word);
}
