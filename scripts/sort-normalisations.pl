#!/usr/bin/perl

use warnings;
use strict;
use utf8;

my %xforms = (
	'eamhai' => 'iúi',
	'amhai' => 'úi',
	'ighi' => 'í',
	'amhadh' => 'ú',
	'úbhai' => 'úi',
	'ughadh' => 'ú',
	'aidhea' => 'aío',
	'aidhe' => 'aí',
	'aigheadh' => 'aíodh',
	'aighea' => 'aío',
	'ighea' => 'ío',
	'aidhe' => 'aí',
	'idh' => 'í',
	'uidhe' => 'uí',
	'ui' => 'ai',
	'n' => 'nn',
	'l' => 'll',
	'ó' => 'o',
	'á' => 'a',
	'é' => 'e',
	'í' => 'i',
	'ú' => 'u',
	'eu' => 'éa',
	'sg' => 'sc',
	'th' => '',
);

while(<>) {
	chomp;
	my @wds = split/\t/;
	my $old = $wds[0];
	my $new = $wds[1];

	if($old =~ / / && $new !~ / /) {
		my $tmp = $old;
		$tmp =~ s/ //;
		if ($tmp eq $new) {
			print "$old\t$new\n";
			next;
		}
	}
	if($old =~ /\-/ && $new !~ /\-/) {
		my $tmp = $old;
		$tmp =~ s/\-//;
		if ($tmp eq $new) {
			print "$old\t$new\n";
			next;
		}
	}
	if($new =~ / / && $old !~ / /) {
		my $tmp = $new;
		$tmp =~ s/ //;
		if ($tmp eq $old) {
			print "$old\t$new\n";
			next;
		}
	}

	for my $xf (keys %xforms) {
		my $tmp = $old;
		$tmp =~ s/$xf/$xforms{$xf}/;
		if($tmp eq $new) {
			print "$old\t$new\n";
			last;
		}
	}
}
