#!/usr/bin/perl
use warnings;
use strict;
use utf8;

use LWP::Simple;

open(OUT, '>', 'frasa-an-lae.tsv');
binmode(OUT, ":utf8");
binmode(STDOUT, ":utf8");

#youtube-dl -o '%(id)s.%(ext)s' -i 'PL7wLVDMegS1TtcBXhoudRs8E_Wze7VN5-'
#youtube-dl -o '%(id)s.%(ext)s' -i 'PL899AB1D03F65EF58'

my $page = get('https://www.gaelchultur.com/ga/frasa_an_lae.aspx');

my @lines = split/\n/, $page;

for my $line (@lines) {
    chomp($line);
    if($line =~ m!<tr><td>[^<]+</td><td>(.*)</td><td>.*</td><td><a href="http://www.youtube.com/watch\?v=([^"\&]+)[^\&]*" target="_blank">Físeán</a></td></tr>!) {
        my $id = $2;
        my $text = $1;
        my $find = '';
        my $repl = '';
        if($text =~ s/<br \/>\* ?pronounced ['‘]([^']+)['’]//) {
            $repl = $1;
            if($text =~ /Beidh mé\*/) {
                $find = 'Beidh mé';
                $text =~ s/$find\*/$repl/;
            }
            elsif($text =~ /([^ *]+)\*/) {
                $find = $1;
                $text =~ s/$find\*/$repl/;
            } else {
                print STDERR "Error finding replacement: $line\n";
            }
            
        }
        $text =~ s/●/-/g;
        $text =~ s/  +/ /g;
        $text =~ s/<br \/>/ /g;
        $text =~ s/\// /g;
        print OUT "$id\t$text";
        print OUT "\t$find\t$repl" if($find ne '');
        print OUT "\n";
    }
}
