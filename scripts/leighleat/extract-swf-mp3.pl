#!/usr/bin/perl
use warnings;
use strict;
use utf8;

if (!@ARGV) {
	die "No filename(s) provided";
}

if (`which swfextract` eq '') {
	die "Can't find swfextract - do you have swftools installed?";
}

for my $file (@ARGV) {
	my $output = `swfextract "$file"|grep MP3`;
	my $name = mkname($file);
	print "$name\n";

	my @ids = ();
	if($output =~ /\[\-M\] [0-9]+ Embedded MP3s: ID\(s\) (.*)/) {
		my $tmp = $1;
		for my $id (split/,/, $tmp) {
			$id =~ s/^ //;
			$id =~ s/ $//;
			if($id =~ /\-/) {
				my ($a, $b) = split/\-/, $id;
				for(my $i = $a; $i <= $b; $i++) {
					push @ids, $i;
				} 
			} else {
				push @ids, $id;
			}
		}
	}
	for my $out (@ids) {
		system("swfextract -M $out \"$file\" -o ${name}_${out}.mp3");
		if ($? == -1) {
			die "Failed to extract stream $out in file $name";
		}
	}
}

sub mkname {
	my $name = shift;
	$name = lc($name);
	$name =~ s/\.swf$//g;
	$name =~ s/á/a/g;
	$name =~ s/é/e/g;
	$name =~ s/í/i/g;
	$name =~ s/ó/o/g;
	$name =~ s/ú/u/g;
	$name =~ s/[^a-z0-9]//g;
	return uc($name);
}
