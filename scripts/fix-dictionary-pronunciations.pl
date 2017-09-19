#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDIN, ":utf8");

my %tweak = (
    'áit éigin' => '',
    'ar shlí éigin' => 't',
    'am éigin' => '',
    'ar bhealach éigin' => 't',
    'ar chuma éigin' => 't',
    'ar dhóigh éigin' => 't',
    'éigin' => '',
);

my %fixU = (
    'éigin' => 'inteacht'
);
my %fixC = (
    'éigin' => 'eicint'
);
my %fixM = (
    'éigin' => 'éigin'
);

while(<>) {
    chomp;
    my $dialect = '';
    if (/\/Can([CUM])\//) {
        $dialect = $1;
    }
    s/\.mp3$//;
    my @tmp = split/\//;
    my $text = my $tmp[$#tmp];
    
}
