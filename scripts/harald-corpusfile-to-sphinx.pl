#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

my $clean = 0;
my $pfx = 'spabair';

open(TEXT, '>', "${pfx}_train.transcription");
binmode(TEXT, ":utf8");
open(DIC, '>', "$pfx.dic");
binmode(DIC, ":utf8");

my %prons = ();

my %keepapos = (
	"'réir" => 1,
);

sub clean {
	my $word = shift;
	$word =~ s/[\.,;:]//g;
	$word =~ s/'$//;
	$word =~ s/^'// unless (exists $keepapos{$word});
	$word;
}
sub mkoutword {
	my $word = shift;
	my $num = shift;
	my $clean = shift;

	my $subscr = ($num == 1) ? '' : "($num)";
	if($clean) {
		$word = clean($word);
	}
	return $word . $subscr;
}

while(<>) {
	chomp;
	my @line = split/\t/;
	if($#line != 4) {
		print STDERR "Incorrect number of elements: $_\n";
		next;
	}
	my $id = $line[0];
	my $speaker = $line[1];
	my $path = $line[2];
	my $text = $line[3];
	my $pron = $line[4];

	my @phones = split/ ?# ?/, $pron;
	my @words = split/ /, $text;
	my @outwords = ();
	if($#phones != $#words) {
		print STDERR "Text/phone mismatch: $_\n";
		next;
	}
	for(my $i = 0; $i <= $#words; $i++) {
		if(!exists $prons{$words[$i]}{$phones[$i]}) {
			if(!exists $prons{$words[$i]}) {
				$prons{$words[$i]}{$phones[$i]} = 1;
				$outwords[$i] = $words[$i];
			} else {
				my $size = keys %{$prons{$words[$i]}};
				$size++;
				$prons{$words[$i]}{$phones[$i]} = $size;
				$outwords[$i] = mkoutword($words[$i], $size, $clean);
			}
		} else {
			my $idx = $prons{$words[$i]}{$phones[$i]};
			$outwords[$i] = mkoutword($words[$i], $idx, $clean);
		}
	}
	print TEXT "<s> " . join(' ', @outwords) . " </s> ($id)\n";	
}

for my $dicword (keys %prons) {
	for my $curpron (keys %{$prons{$dicword}}) {
		my $idx = $prons{$dicword}{$curpron};
		my $oword = mkoutword($dicword, $idx, $clean);
		print DIC "$oword $curpron\n";
	}
}
