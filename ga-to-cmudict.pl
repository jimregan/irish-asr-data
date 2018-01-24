#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use Data::Dumper;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

my %map = (
  "aː" => ['AA', 'EY'],
  "a" => ['AA', 'AH', 'AE'],
  "ai" => ['AY'],
  "au" => ['AW'],
  "bʲ" => ['B', 'B Y'],
  "bˠ" => ['B', 'B W'], 
  "dʲ" => ['D', 'D Y', 'JH'],
  "d̪ˠ" => ['D', 'D W'],
  "ʤ" => ['JH'],
  "ə" => ['AH'],
  "eː" => ['EH', 'EY'],
  "e" => ['EH', 'EY'],
  "fʲ" => ['F', 'F Y'],
  "fˠ" => ['F', 'F W'],
  "ɟ" => ['G', 'G Y'],
  "ɡ" => ['G', 'G W'],
  "ɣ" => ['G', 'G W', 'G H', 'G H W'],
  "j" => ['Y'],
  "hʲ" => ['H', 'H Y'],
  "h" => ['H', 'H W'],
  "ia" => ['IY AA', 'IY EH', 'IY AA'],
  "iː" => ['IY'],
  "i" => ['IH'],
  "iˑə" => ['IY AH', 'IH AH'],
  "c" => ['K', 'K Y'],
  "k" => ['K', 'K W'],
  "lʲ" => ['L', 'L Y'],
  "l̻̊ˠ" => ['L', 'L W'],
  "l̻̊ʲ" => ['L', 'L Y'],
  "l̻ˠ" => ['L', 'L W'],
  "mʲ" => ['M', 'M Y'],
  "mˠ" => ['M', 'M W'],
  "ɲ" => ['N', 'N Y'],
  "n̥ʲ" => ['N', 'N Y'],
  "nʲ" => ['N', 'N Y'],
  "n̻̊ˠ" => ['N', 'N W'],
  "ŋ" => ['NG', 'NG W'],
  "n̻ʲ" => ['N', 'N Y'],
  "n̻ˠ" => ['N', 'N W'],
  "oː" => ['AO', 'OW'],
  "o" => ['AA'],
  "pʲ" => ['P', 'P Y'],
  "pˠ" => ['P', 'P W'],
  "ɾʲ" => ['R', 'T', 'R Y', 'T Y'],
  "ɾˠ" => ['R', 'T', 'R W', 'T W'],
  "ɾ̥ˠ" => ['R', 'T', 'R W', 'T W'],
  "ɾ̥ʲ" => ['R', 'T', 'R Y', 'T Y'],
  "ʃ" => ['SH', 'S Y'],
  "sˠ" => ['S', 'S W'],
  "tʲ" => ['T Y', 'T', 'CH'],
  "t̪ˠ" => ['T', 'T W'],
  "ua" => ['UW AA', 'UW EH', 'UW AA'],
  "uː" => ['UW'],
  "u" => ['AH', 'UH'],
  "uˑə" => ['UW AH', 'UH AH', 'UW W AH'],
  "vʲ" => ['V', 'V Y'],
  "vˠ" => ['V', 'V W'],
  "ç" => ['H', 'K', 'H Y', 'K Y'],
  "x" => ['H', 'K'],
);

my %unmapped = ();

sub getmap {
  my $key = shift;
  if(exists $map{$key}) {
    return $map{$key};
  } else {
    if(!exists $unmapped{$key}) {
      print STDERR "Unmapped: $key\n";
      $unmapped{$key} = 1;
    }
    return [];
  }
}

sub printentry {
  my $word = shift;
  my $mappings = shift;
  for my $m (@$mappings) {
    print "$word $m\n";
  }
}

sub expand {
  my $acc = shift;
  my $rest = shift;
  if(!@$rest) {
    return @$acc;
  }
  my $cur = shift @$rest;
  if(!@$acc) {
    return expand($cur, $rest);
  } else {
    my @next = ();
    map { my $item = $_; push @next, map {"$item ". $_} @$cur } @$acc;
    return expand(\@next, $rest);
  }
}

while(<>) {
  chomp;
  my @entry = split/[ \t]/;
  my $word = shift @entry;
  my @rmap = map { getmap($_) } @entry;
  my @mapped = expand([], \@rmap);
  printentry($word, \@mapped);
}


