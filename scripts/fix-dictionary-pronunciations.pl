#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

my %tweak = (
    'áit éigin' => 't',
    'ar shlí éigin' => 't',
    'am éigin' => 'fM',
    'ar bhealach éigin' => 't',
    'ar chuma éigin' => 't',
    'ar dhóigh éigin' => 't',
    'éigin' => '',
);

my %fixU = (
    'éigin' => 'inteacht'
);
my %fixC = (
    'éigin' => 'eicint',
    'zúmáil' => 'súmáil',
    'zúm' => 'súm',
    'zipeáil' => 'sipeáil',
    'zip' => 'sip',
    #vótóir = wótóir

);
my %fixM = (
    'éigin' => 'éigint',
    'fáil' => 'fáilt',
    # zónáilte = zónáilthe
);

sub get_replacement {
    my $word = $_[0];
    my $dialect = $_[1];
    if ($dialect eq 'M') {
        if(exists $fixM{$word}) {
            return $fixM{$word};
        } else {
            return $word;
        }
    }
    if ($dialect eq 'U') {
        if(exists $fixU{$word}) {
            return $fixU{$word};
        } else {
            return $word;
        }
    }
    if ($dialect eq 'C') {
        if(exists $fixC{$word}) {
            return $fixC{$word};
        } else {
            return $word;
        }
    }
}

while(<>) {
    chomp;
    my $dialect = '';
    if (/\/Can([CUM])\//) {
        $dialect = $1;
    }
    s/\.mp3$//;
    my $text = '';
    if(/\/([^\/]*)$/) {
        $text = $1;
    }
    if(/éigin$/) {
        if($dialect ne 'M' && ($text ne 'éigin' || $text ne 'am éigin')) {
            my $replacement = get_replacement('éigin', $dialect);
            $text =~ s/éigin/$replacement/;
            print "$text\n";
        } else {
            print "$text\n";
        }
    } else {
        print get_replacement($text, $dialect) . "\n";
    }
}
