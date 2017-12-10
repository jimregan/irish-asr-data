#!/usr/bin/perl
# Copyright 2017 Jim O'Regan
# Apache 2.0

use warnings;
use strict;
use utf8;

my $expecting = 0;
my $leftsec = 0.0;
my $rightsec = 0.0;
my $text = '';
while(<>) {
    chomp;
    s/\r//g;
    next if(/^WEBVTT/);
    next if(/X-TIMESTAMP/);
    next if(!$expecting && /^$/);
    if(/(\d{2}):(\d{2}):(\d{2})\.(\d{3}) --> (\d{2}):(\d{2}):(\d{2})\.(\d{3})/) {
        my $lhr = $1;
        my $lmn = $2;
        my $lsc = $3;
        my $lfr = $4;
        my $rhr = $5;
        my $rmn = $6;
        my $rsc = $7;
        my $rfr = $8;
        $lsc += ($lmn * 60) + ($lhr * 3600);
        $leftsec = "$lsc.$lfr";
        $rsc += ($rmn * 60) + ($rhr * 3600);
        $rightsec = "$rsc.$rfr";

        $expecting = 1;
        $text = '';
    } elsif($expecting && /^$/) {
        $text =~ s/  +/ /g;
        print "$leftsec\t$rightsec\t$text\n";
    } else {
        if($text eq '') {
            $text = $_;
        } else {
            $text .= " $_";
        }
    }
}
