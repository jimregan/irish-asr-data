#!/usr/bin/perl

use warnings;
use strict;
use utf8;

my %phones = ();

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

print "SIL\n";
while(<>) {
    chomp;
    my ($a, $b) = split/\t/;
    my @phn = split/ /, $b;
    for my $phone (@phn) {
        if(!exists $phones{$phone}) {
            $phones{$phone} = 1;
            print "$phone\n";
        }
    }
}
