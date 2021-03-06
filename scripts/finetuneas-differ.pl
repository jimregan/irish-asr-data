#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use JSON;
use File::Slurp;
use Data::Dumper;
use Algorithm::Diff qw(diff);
binmode(STDOUT, ":utf8");

my $rawjsonl = read_file($ARGV[0]);
my $rawjsonr = read_file($ARGV[1]);
my @path = split/\//, $ARGV[0];
my $fname = $path[$#path];
$fname =~ s/\.json$//;

my $jsonl = decode_json($rawjsonl);
my $jsonr = decode_json($rawjsonr);

sub checkseq {
	my $in = shift;
	my @arr = sort { $a <=> $b } keys %$in;
	return 1 if($#arr == 0);
	for(my $i = 0; $i < $#arr; $i++) {
		return 0 if($arr[$i] != ($arr[$i + 1] - 1));
	}
	return 1;
}

my %comp = ();
if(exists $jsonl->{'fragments'}) {
	for my $frag (@{$jsonl->{'fragments'}}) {
		$comp{$frag->{'id'}} = $frag;
	}
}
if(exists $jsonr->{'fragments'}) {
	for my $frag (@{$jsonr->{'fragments'}}) {
		if(exists $comp{$frag->{'id'}}) {
			my $right = join(" ", @{$frag->{'lines'}});
			# @{$comp{$frag->{'id'}}->{'lines'}} <- this is why people hate perl
			my $left = join(" ", @{$comp{$frag->{'id'}}->{'lines'}});
			my @lwords = split/ /, $left;
			my @rwords = split/ /, $right;
			my @diffs = diff(\@lwords, \@rwords);
			if(@diffs) {
				for my $diffg (@diffs) {
					my %plus = ();
					my %minus = ();
					for my $diff (@$diffg) {
						if($$diff[0] eq '-') {
							$plus{$$diff[1]} = $$diff[2];
						} elsif($$diff[0] eq '+') {
							$minus{$$diff[1]} = $$diff[2];
						} else {
							print "Error in diff: @$diff\n";
						}
					}
					#print "Error: " . Dumper(@$diffg) . "\n" if(!checkseq \%plus);
					my @tmp = ();
					for my $aplus (sort { $a <=> $b } keys %plus) {
						push @tmp, $plus{$aplus};
					}
					my $plusstr = join(" ", @tmp);
					@tmp = ();
					for my $aminus (sort { $a <=> $b } keys %minus) {
						push @tmp, $minus{$aminus};
					}
					my $minusstr = join(" ", @tmp);
					@tmp = ();
					print "$fname\t$frag->{'id'}\t$minusstr\t$plusstr\n";
				}
			}
		} else {
			print STDERR "id not found: $frag->{'id'}\n";
		}
	}
}

