#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

while(<>) {
	chomp;
	my @line = split/ /;
	my $id = shift @line;
	my $sent = join(' ', @line);
	print "<s> $sent </s> ($id)\n";
}
