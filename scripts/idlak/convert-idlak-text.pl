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

open(FIXES, ">", "lexicon-fixes.tsv");
binmode(FIXES, ":utf8");

sub lower_irish_word {
	my $word = shift;
	if($word =~ /^([nt])([AEIOUÁÉÍÓÚ].*)/) {
		my $pfx = $1;
		my $rest = $2;
		my $lwr = lc($rest);
		my $lword = lc($word);
		my $out = $pfx . '-' . $lwr;
		print FIXES "$lword\t$out\n";
		return "$out";
	} else {
		return lc($word);
	}
}

sub tolower {
	my $t = shift;
	my @words = split/ /, $t;
	my @res = map { lower_irish_word $_ } @words;
	return join(' ', @res);
}

my $dom = XML::LibXML->load_xml(location => $filename) or die "$!";

foreach my $utt ($dom->findnodes('//fileid')) {
	my $text = NFC($utt->to_literal());
	my $id = $utt->{'id'};
	if(exists $stripapos{$id}) {
		$text =~ s/'//g;
	} elsif($id eq 'cll_z0002_319') {
		$text =~ s/ '/ /;
		$text =~ s/' / /;
	}
	$text =~ s/[\?!\.,":;]//g;
	my $out = tolower($text);
	print "$id\t$out\n";
}
