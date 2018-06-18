#!/usr/bin/perl
# Simple wrapper around pdftotext that takes a page range
# and discards page numbers at the top/bottom of the page

use warnings;
use strict;
use utf8;

use Getopt::Long;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

my $first_page = 1;
my $last_page = 1;
my $pagenums = 'none';

my $res = GetOptions("first=i" => \$first_page,
           "last=i" => \$last_page,
           "pagenums=s" => \$pagenums);

my $file = $ARGV[0];

if (! -e $file) {
	die "Can't file $file\n";
}

if(`which pdftotext` eq '') {
	die "Can't find pdftotext\n";
}

for(my $i = $first_page; $i <= $last_page; $i++) {
	open(my $cmdin, "-|:raw", "pdftotext -nopgbrk -eol unix -f $i -l $i \"$file\" -");
	binmode($cmdin, ":utf8");
	my $text = join('', <$cmdin>);
	my @lines = split/\n/, $text;
	my @filt = ();
	for my $line (@lines) {
		if($line ne '') {
			push @filt, $line;
		}
	}
	if($pagenums eq 'first' && @filt && $filt[0] =~ /^\s*[0-9]+\s*$/) {
		shift @filt;
	} elsif($pagenums eq 'last' && @filt && $filt[$#filt] =~ /^\s*[0-9]+\s*$/) {
		pop @filt;
	}
	print join("\n", @filt) . "\n";
	close($cmdin);
}
