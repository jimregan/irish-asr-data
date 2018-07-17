#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use JSON;
use File::Slurp;
use Data::Dumper;

#binmode(STDOUT, ":utf8");
my $fn = $ARGV[0];

my $rawjson = read_file($fn);

my $json = decode_json($rawjson);
if(exists $json->{'fragments'}) {
	for (my $i=0; $i < $#{$json->{'fragments'}}; $i++) {
		my $cur = ${$json->{'fragments'}}[$i];
		my $next = ${$json->{'fragments'}}[$i + 1];

		if($cur->{'end'} > $next->{'begin'}) {
			$cur->{'end'} = $next->{'begin'};
		}
	}
}
print encode_json($json);
