#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use Text::Aspell;
my $ga = Text::Aspell->new;
my $en = Text::Aspell->new;
$ga->set_option('lang','ga');
$en->set_option('lang','en_GB');

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

sub irishlc {
    my $word = shift;
    $word =~ s/([nt])([AEIOUÁÉÍÓÚ])/$1-$2/;
    return lc($word);
}

while(<>) {
    chomp;
    next if(/^#/);
    s/[\.,!\?\(\)\[\]“”";]/ /g;
    s/’/'/g;
    s/  +/ /g;
    for my $word(split / /) {
        $word =~ s/^'//;
        $word =~ s/'$//;
        my $lci = irishlc($word);
        my $lc = lc($word);
        if($word =~ /^[0-9]+$/) {
            print "num\t$word\n";
        } elsif($ga->check($lci)) {
            if($en->check($lci)) {
                print "both\t$lci\n";
            } else {
                print "ga\t$lci\n";
            }
        } elsif($ga->check($word)) {
            if($en->check($lci)) {
                print "both\t$word\n";
            } else {
                print "ga\t$word\n";
            }
        } elsif($en->check($lc)) {
            print "en\t$lc\n";
        } elsif($en->check($word)) {
            print "en\t$word\n";
        } else {
            print "No match\t$word\n";
        }
    }
}

