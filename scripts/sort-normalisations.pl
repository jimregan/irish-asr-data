#!/usr/bin/perl

use warnings;
use strict;
use utf8;

my %xforms = (
	'eamhai' => 'iúi',
	'n' => 'nn',
	'l' => 'll',
	'ó' => 'o',
	'á' => 'a',
	'é' => 'e',
	'í' => 'i',
	'ú' => 'u',
	'eu' => 'éa',
	'amhadh' => 'ú',
	'sg' => 'sc',
	'úbhai' => 'úi',
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
		if ($tmp eq $new) {
			print "$old\t$new\n";
			next;
		}
	}

#	for my $xf (keys %xforms) {
#		my $
#	}
}
