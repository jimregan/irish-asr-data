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
open(NORM, "$RealBin/normalisations.tsv");
binmode(NORM, ":utf8");
while(<NORM>) {
    chomp;
    next if(/^#/);
    my ($a, $b) = split/\t/;
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

    s/\bi n[-']aice /in aice /gi;
    s/\ble n-a /lena /gi;
    s/\b[Gg]ur ?bh’ ?/gurbh /gi;
    s/\b[Gg]ur ?b’ ?/gurb /gi;
    s/\b[Nn]ár bh’ ?/nárbh /gi;
    s/\b[Dd]ár bh’ ?/dárbh /gi;
    s/\b[Dd]’ár bh’ ?/dárbh /gi;
    s/\b[Cc]ár bh’ ?/cárbh /gi;
    s/\b[Nn]íor bh’ ?/níorbh /gi;
    s/\bníb’ /níb'/gi;
    s/\bmb’ fhéidir\b/mb'fhéidir/gi;
    s/\bb’ fhéidir\b/b'fhéidir/gi;
    s/\bm’ /m'/gi;
    s/\bd’ /d'/gi;
    s/\b[Cc]é ’r bh’ ?/cérbh /gi;
    s/\bi n-aon /in aon/gi;
    s/\b’dh eadh/dhea/gi;
    s/\bb’ /b'/gi;
    s/\bi n-Éirinn/in Éirinn/gi;
    s/\bana bheag/an-bheag/gi;
    s/\bana mhaith/an-mhaith/gi;
    s/\bana mhór/an-mhór/gi;
    s/\bn’ osguil/n'oscail/gi;
    s/\bh-ana mhaith/han-mhaith/gi;
    s/\bh-ana mhinic/han-mhinic/gi;
    s/\bh-ana dheas/han-dheas/gi;
    s/\bh-ana oban/han-oban/gi;
    s/\bh-ana réidh/han-réidh/gi;
    s/\bh-ana bhuartha/han-bhuartha/gi;

    s/’/'/g;

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
