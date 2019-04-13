#!/usr/bin/perl

use warnings;
use strict;
use utf8;

my $file = $ARGV[0];

my $probe = `ffprobe -select_streams v -show_frames $file`;

my $lno = 0;
my $cur = '';
my $last = 0;
my $adjust = 0.000010;
for my $line (split /\n/, $probe) {
    if($line =~ /best_effort_timestamp_time=(.*)/) {
        $cur = $1;
        my $cout = $cur - $adjust;
        print "$last\t$cout\t$lno\n";
	$last = $cur;
        $lno++;
    } else {
        next;
    }
}
