#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use Text::Aspell;

my %broad = (
  "n-" => 'n̻ˠ',
  "t-" => 't̪ˠ',
  "m'" => 'mˠ',
  "d'" => 'd̪ˠ',
  "b'" => 'bˠ',
  "mb'" => 'mˠ',
);
my %slender = (
  "n-" => 'nʲ',
  "t-" => 'tʲ',
  "m'" => 'mʲ',
  "d'" => 'dʲ',
  "b'" => 'bʲ',
  "mb'" => 'mʲ',
);

my $speller = Text::Aspell->new;
die unless $speller;
$speller->set_option('lang','ga');

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

while(<STDIN>) {
    chomp;
    my ($word, $pron) = split/\t/;
    my $acc = ($pron =~ s/^ˈ //) ? "ˈ " : "";
    if(/^[aouáóúAOUÁÓÚ]/ || /^[Ff]h[aouáóú]/) {
        for my $start (keys %broad) {
            my $start_out = $start;
            if($word =~ /^[AOUÁÓÚ]/) {
                $start_out =~ s/\-//;
            }
            my $new = $start_out . $word;
            if($speller->check($new)) {
                print $new . "\t$acc" . $broad{$start} . ' ' . $pron . "\n";
            }
        }
    } elsif (/^[eiéíEIÉÍ]/ || /^[Ff]h[eiéí]/) {
        for my $start (keys %broad) {
            my $start_out = $start;
            if($word =~ /^[EIÉÍ]/) {
                $start_out =~ s/\-//;
            }
            my $new = $start_out . $word;
            if($speller->check($new)) {
                print $new . "\t$acc" . $slender{$start} . ' ' . $pron . "\n";
            }
        }
    }
}
