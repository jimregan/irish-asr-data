#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use XML::LibXML;
use Data::Dumper;

binmode(STDOUT, ":utf8");
open(TRANS, '>>', "transcripts.txt");
binmode(TRANS, ":utf8");
open(LEX, '>>', "lex.txt");
binmode(LEX, ":utf8");

my %norm_word = (
    "'b'fhada" => "b'fhada",
    "'b'fhéidir," => "b'fhéidir,",
    "'b'fhéidir" => "b'fhéidir",
    "'d'aithneofá" => "d'aithneofá",
    "'d'éirigh" => "d'éirigh",
    "'d'fhág" => "d'fhág",
    "''d'fhan" => "d'fhan",
    "'d'fhan" => "d'fhan",
    "'d'imigh" => "d'imigh",
    "'d'ól" => "d'ól",
    "'m'aint" => "m'aint",
    "'m'anam" => "m'anam",
    "b'fhearr.'" => "b'fhearr",
    "b'fhéidir.'" => "b'fhéidir",
    "d'eibhlín.'" => "d'eibhlín",
    "m'ais.'" => "m'ais",
    "m'fháinleoígínse.'" => "m'fháinleoígínse",
    "m'fhuinneoigese.'" => "m'fhuinneoigese",
    "mh'anam,'" => "mh'anam",
    "b'fhéidir," => "b'fhéidir",
    "b'fhéidir." => "b'fhéidir",
    "d'adhmad;" => "d'adhmad",
    "d'athair?" => "d'athair",
    "d'eibhlín." => "d'eibhlín",
    "m'athair," => "m'athair",
    "m'athair." => "m'athair",
    "m'athairse," => "m'athairse",
    "m'athar." => "m'athar",
    "mb'uafar." => "mb'uafar",
    "m'éadain." => "m'éadain",
    "m'fhear," => "m'fhear",
    "b'fhéidir," => "b'fhéidir",
);

sub proc_file {
    my $filename = shift;
    my $parser = XML::LibXML->new();
    my $doc    = $parser->load_xml(location => $filename);

    my $root = $doc->documentElement;
    my($utt) = $root->findnodes('/utterance/sentence');
    my $input_string = $utt->getAttribute("input_string");
    if($input_string) {
        print TRANS "$input_string\n";
    }
    my $reconstructed = '';

    my %strs = (
        '0' => ".",
        'None' => ".",
        '1' => "\N{U+02C8}",
        '2' => "\N{U+02CC}"
    );

    foreach my $xword ($doc->findnodes('/utterance/sentence/token/word')) {
        my $input_string = $xword->getAttribute("input_string");
        my $string = $xword->getAttribute("string");
        my $word = ($input_string) ? $input_string : ($string) ? $string : "<sil>";
        if(exists $norm_word{$word}) {
            $word = $norm_word{$word};
        }
        if($input_string || $string) {
            print LEX "$word\t";
            if($word ne 'silence') {
                $reconstructed .= " $word";
            }
        } else {
            print LEX "<sil>\t";
        }
        for my $syl ($xword->findnodes('syllable')) {
            my $stress = $syl->getAttribute('stress');
            if($stress) {
                if(!$strs{$stress}) {
                    print STDERR "$stress\n";
                }
                print LEX "$strs{$stress} ";
            }
            for my $phone ($syl->findnodes('phoneme')) {
                my $ph = $phone->getAttribute('symbol');
                print LEX "$ph ";
            }
        }
        print LEX "\n";
    }
    if(!$input_string) {
        print TRANS "$reconstructed\n";
    }
}

for(my $i = 0; $i <= $#ARGV; $i++) {
    proc_file($ARGV[$i]);
}
