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
my $append = '';
my $leftx;
my $rightx;
my $y;
my $width;
my $height;
my $firstside;
my $lastside;

my $res = GetOptions("first=i" => \$first_page,
           "last=i" => \$last_page,
           "pagenums=s" => \$pagenums,
           "appendpunct=s" => \$append,
           "leftx=i" => \$leftx,
           "rightx=i" => \$rightx,
           "y=i" => \$y,
           "width=i" => \$width,
           "height=i" => \$height,
           "firstside=s" => \$firstside,
           "lastside=s" => \$lastside);

my $cmdleft = '';
my $cmdright = '';
if($leftx || $rightx || $y || $width || $height || $firstside || $lastside) {
	my @set = ();
	my @unset = ();
	if(!$leftx) {
		push @unset, "--leftx";
	} else {
		push @set, "--leftx";
	}
	if(!$rightx) {
		push @unset, "--rightx";
	} else {
		push @set, "--rightx";
	}
	if(!$y) {
		push @unset, "--y";
	} else {
		push @set, "--y";
	}
	if(!$width) {
		push @unset, "--width";
	} else {
		push @set, "--width";
	}
	if(!$height) {
		push @unset, "--height";
	} else {
		push @set, "--height";
	}
	if(!$firstside) {
		push @unset, "--firstside";
	} else {
		push @set, "--firstside";
	}
	if(!$lastside) {
		push @unset, "--lastside";
	} else {
		push @set, "--lastside";
	}
	if(@set && @unset) {
		print "Error: option(s) " . join(", ", @set) . " used without: " . join(", ", @unset) . "\n";
		die;
	}
	$cmdleft = " -x $leftx -y $y -W $width -H $height";
	$cmdright = " -x $rightx -y $y -W $width -H $height";
}

my %appendpages = ();
if($append ne '') {
	if ($append !~ /^([0-9]+[0-9,])*[0-9]+$/) {
		die "--appendpunct takes a comma separated list of page numbers. Got: $append\n";
	}
	for my $num (split/,/, $append) {
		$appendpages{$num} = 1;
	}
}

my $file = $ARGV[0];

if (! -e $file) {
	die "Can't file $file\n";
}

if(`which pdftotext` eq '') {
	die "Can't find pdftotext\n";
}

for(my $i = $first_page; $i <= $last_page; $i++) {
	my $text = '';
	if($cmdleft eq '' && $cmdright eq '') {
		open(my $cmdin, "-|:raw", "pdftotext -nopgbrk -eol unix -f $i -l $i \"$file\" -");
		binmode($cmdin, ":utf8");
		$text = join('', <$cmdin>);
		close($cmdin);
	} else {
		if(!($i == $first_page && $firstside eq 'r')) {
			open(my $cmdinl, "-|:raw", "pdftotext -nopgbrk -eol unix -f $i -l $i $cmdleft \"$file\" -");
			binmode($cmdinl, ":utf8");
			$text = join('', <$cmdinl>);
			close($cmdinl);
		}
		if(!($i == $last_page && $lastside eq 'l')) {
			open(my $cmdinr, "-|:raw", "pdftotext -nopgbrk -eol unix -f $i -l $i $cmdright \"$file\" -");
			binmode($cmdinr, ":utf8");
			$text .= join('', <$cmdinr>);
			close($cmdinr);
		}
	}
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
	if(@filt && exists $appendpages{$i}) {
		$filt[0] .= '.';
	}
	print join("\n", @filt) . "\n";
}
