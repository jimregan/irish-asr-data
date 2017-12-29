#!/usr/bin/perl

use warnings;
use strict;
use utf8;
use Data::Dumper;

use WWW::Mechanize;
my $mech = WWW::Mechanize->new();

my $u = 'http://www.abair.tcd.ie/?view=words&lang=gle&page=synthesis&synth=gd&xpos=&ypos=&speed=Gnáthluas&pitch=1.0&colors=default';
my $c = 'http://www.abair.tcd.ie/?synth=hts&lang=gle&page=synthesis&submit=true&view=words&xpos=&ypos=&speed=Gnáthluas&pitch=1.0&colors=default';
my $m = 'http://www.abair.tcd.ie/?synth=ga_MU_nnc_exthts&lang=gle&page=synthesis&submit=true&view=words&xpos=&ypos=&speed=Gnáthluas&pitch=1.0&colors=default';

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

my $url = '';
if($ARGV[0] =~ /^[Uu]/) {
    $url = $u;
} elsif($ARGV[0] =~ /^[Cc]/) {
    $url = $c;
} else {
    $url = $m;
}
$mech->get($url);

open(IN, '<', $ARGV[1]);
binmode(IN, ":utf8");

my $query = '';
my @qwords = ();

while(<IN>) {
    chomp;
    push @qwords, $_;
#    $query .= "$_ .\n";
    $query .= "$_\n";
}

$mech->submit_form(form_name => 'synthesis',
                   fields => {
                      'input' => $query 
                   });
$mech->save_content('/tmp/htmout', binmode => ':utf8');
