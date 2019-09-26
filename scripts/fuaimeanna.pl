#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use URI;
use Web::Scraper;
use Data::Dumper;

binmode(STDOUT, ":utf8");

my $phones = scraper {
    process 'div[class="friotal"]', 'sounds[]' => scraper {
        process 'span[class="ortho"]', 'orth' => 'TEXT';
        process 'span[class="taifead"] span[class="player"] a audio source', 'sounds[]' => '@src';
        process 'span[class="phonological"]', 'dialects[]' => scraper {
            process 'a[class="phoneme"]', 'phonemes[]' => 'TEXT';
        };
    };
};

#my $base = 'http://www.fuaimeanna.ie/en/Recordings.aspx';

#for my $i (1..77) {
my $i = 1;
    my $res = $phones->scrape(URI->new("http://www.fuaimeanna.ie/en/Recordings.aspx?Page=$i"));

    for my $sound (@{$res->{'sounds'}}) {
        my $word = $sound->{'orth'};
        $word =~ s/^<//;
        $word =~ s/>$//;
        if($#{$sound->{'sounds'}} != 2 && $#{$sound->{'dialects'}} != 2) {
            print STDERR "Error reading <$word> on page $i";
        }
        print "$word\t";
        for my $j (0..2) {
            print ${$sound->{'sounds'}}[$j] . "\t" . join(' ', @{${$sound->{'dialects'}}[$j]->{'phonemes'}});
            print "\t" unless ($j == 2);
        }
        print "\n";
    }
#}