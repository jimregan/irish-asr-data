#!/usr/bin/perl
# Recreates labels created by fuaimeanna.pl (all-fuaimeanna-data.tsv)
# Creates a set of labels in 'label/' (which must exist)

use warnings;
use strict;
use utf8;

use URI;
use Web::Scraper;
use Data::Dumper;

binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");
open(INPUT, "<", "all-fuaimeanna-data.tsv");
binmode(INPUT, ":utf8");

if(! -d "label") {
    die "Directory 'label' does not exist\n";
}

my $reading = 0;

while(<INPUT>) {
    chomp;
    if($reading == 0 && /^Orthographic/) {
        $reading = 1;
        next;
    }
    my @pieces = split/\t/;
    my @sounds = ($pieces[1], $pieces[3], $pieces[5]);
    my @phones = ($pieces[2], $pieces[4], $pieces[6]);

    for my $j (0..2) {
        my $sound_raw = $sounds[$j];
        my $phones_raw = $phones[$j];

        my $sound_base = $sound_raw;
        $sound_base =~ s!/sounds/!!;
        $sound_base =~ s/\.mp3//;
            
        my $phones_out = $phones_raw;
        # discard word boundary
        $phones_out =~ s/ \# / /g;
        $phones_out =~ s/\.//g;
        $phones_out =~ s/ˈ//g;
        $phones_out =~ s/\s+/ /g;
        $phones_out =~ s/^ //;
        $phones_out =~ s/ $//;
            
        # write the phones to the label file
        my $label_file = "label/$sound_base.phones";
        open(OUT, ">", $label_file);
        binmode(OUT, ":utf8");
        print OUT "$phones_out";
        close(OUT);
    }
}