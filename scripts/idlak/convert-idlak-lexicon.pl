#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use XML::LibXML;
use Unicode::Normalize;

binmode(STDOUT, ":utf8");

# https://raw.githubusercontent.com/Idlak/idlak/master/idlak-data/ga/ie/lexicon-default.xml
my $filename;
if(exists $ARGV[0]) {
	$filename = $ARGV[0];
} else {
	$filename = 'lexicon-default.xml';
}

my $dom = XML::LibXML->load_xml(location => $filename) or die "$!";

foreach my $lex ($dom->findnodes('//lex')) {
	my $word = NFC($lex->to_literal());
	my $pron = $lex->{'pron'};
	print "$word\t$pron\n";
}
