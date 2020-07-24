#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use XML::LibXML;
use Unicode::Normalize;

binmode(STDOUT, ":utf8");

# https://raw.githubusercontent.com/Idlak/Living-Audio-Dataset/master/ga/ie/cll/text.xml
my $filename;
if(exists $ARGV[0]) {
	$filename = $ARGV[0];
} else {
	$filename = 'text.xml';
}

my %stripapos = map { $_ => 1 } qw(
	cll_z0001_713 cll_z0001_804 cll_z0002_069 cll_z0002_296
	cll_z0002_448 cll_z0002_481 cll_z0002_484 cll_z0002_495
);

my $dom = XML::LibXML->load_xml(location => $filename) or die "$!";

foreach my $utt ($dom->findnodes('//lex')) {
	my $text = NFC($lex->to_literal());
	my $id = $lex->{'id'};
	if(exists $stripapos{$id}) {
		$text =~ s/'//g;
	} elsif($id eq 'cll_z0002_319') {
		$text =~ s/ '/ /;
		$text =~ s/' / /;
	}
	$text =~ s/[\?!\.,"]//g;
	print "$word\t$pron\n";
}
