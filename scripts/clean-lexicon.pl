#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

while(<>){
	chomp;
	my ($lem, $pron) = split/\t/;
	$lem =~ s/[;:,\.!\?]//;
	$lem =~ s/'$//;
}
