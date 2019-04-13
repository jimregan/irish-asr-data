#!/usr/bin/perl

use warnings;
use strict;
use utf8;
use POSIX;

my $input = $ARGV[0];
my $length = $ARGV[1];
my $pct = $ARGV[2];

my %ids = ();
my $amt = ceil($length / 100 * $pct);
while(keys %ids < $amt) {
    my $id = sprintf("%07d", int(rand($length+1)));
    $ids{$id} = 1;
}

open(IN, '<', $input);
binmode(IN, ":utf8");
open(FILEIDS, '>', "etc/teanglann_train.fileids");
open(TFILEIDS, '>', "etc/teanglann_test.fileids");
open(TRANS, '>', "etc/teanglann_train.transcription");
open(TTRANS, '>', "etc/teanglann_test.transcription");

while(<IN>) {
    chomp;
    if(/[^\(]*\(([^\)]*)\)/) {
        my $id = $1;
        if(exists $ids{$id}) {
            print TFILEIDS "$id\n";
            print TTRANS "$_\n";
        } else {
            print FILEIDS "$id\n";
            print TRANS "$_\n";
        }
    } else {
        die "Error: $_\n";
    }
}
