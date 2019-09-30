#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use List::Util qw(max);
use Data::Dumper;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

open(IN, '<', $ARGV[0]);
binmode(IN, ":utf8");
my $basef = $ARGV[0];
$basef =~ s/\.xml//;
open(OUT, '>', "$basef.txt");
binmode(OUT, ":utf8");
open(PROBEN, '>', "$basef.english.txt");
binmode(PROBEN, ":utf8");

my @lines;
my %counts = ();


# first pass: trim non-text, build counts of 'font'
while(<IN>) {
    if(/<text[^>]*font="([0-9]+)"[^>]*>.*<\/text>/) {
        my $font = $1;
        if(exists $counts{$font}) {
            $counts{$font}++;
        } else {
            $counts{$font} = 1;
        }
        push @lines, $_;
    } else {
        next;
    }
}

# Find highest 'font' value
my $most_freq = max(values %counts);
my $count_for_dups = 0;
for my $i (values %counts) {
    if($i == $most_freq) {
        $count_for_dups++;
    }
}
my $most_freq_key = '';
for my $i (keys %counts) {
    if($counts{$i} == $most_freq) {
        $most_freq_key = $i;
    }
}
# If there is just as much text in two fonts, it's likely that the wrong page was extracted
# so quit gracelessly
if($count_for_dups != 1) {
    die<<__END__ 
Fatal: most frequent 'font' type appears more than once. 
Are you sure you're extracting the correct page?
__END__
}
for my $l (@lines) {
    if($l =~ /<text[^>]*font="([0-9]+)"[^>]*>(.*)<\/text>/) {
        my $fnt = $1;
        my $txt = $2;
        if($fnt == $most_freq_key) {
            print OUT "$txt\n";
            while($l =~ /<i>([^<]*)<\/i>/g) {
                print PROBEN "$1\n";
                next;
            }
        }
    }
}