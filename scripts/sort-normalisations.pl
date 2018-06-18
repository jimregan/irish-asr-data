#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

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
	'uigh' => 'ai',
	'ódh' => 'ú',
	'mhth' => 'f',
	'thbh' => 'f',
	'thb' => 'f',
	'ei' => 'i',
	'ighe' => 'í',
	'íghe' => 'í',
	'sgio' => 'scea',
	'ádhbh' => 'ámh',
	'fh' => '',
	'ugh' => 'ú',
	'ana-' => 'an-',
	'ana ' => 'an-',
	'an ' => 'an-',
	'ana-' => 'an',
	'ana ' => 'an',
	'an ' => 'an',
	'an-' => 'an',
	'chómh ' => 'chomh',
	'chómh-' => 'chomh',
	'ui' => 'ai',
	'n' => 'nn',
	'l' => 'll',
	'ó' => 'o',
	'á' => 'a',
	'é' => 'e',
	'í' => 'i',
	'ú' => 'u',
	'u' => 'o',
	'eu' => 'éa',
	'sg' => 'sc',
	'th' => '',
	'\'' => '',
	' ' => '',
	'-' => '',
);

while(<>) {
	chomp;
	my @wds = split/\t/;
	my $old = $wds[0];
	my $new = $wds[1];

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
