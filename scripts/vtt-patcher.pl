#!/usr/bin/perl
# Copyright 2017 Jim O'Regan
# Apache 2.0

open(VTT, $ARGV[0]);
open(IN, $ARGV[1]);
binmode(STDOUT, ":utf8");
binmode(VTT, ":utf8");
binmode(IN, ":utf8");

my %vtt = ();
my %starts = ();
my %ends = ();

my $key = '';
my $newkey = '';
my $text = '';
while(<VTT>) {
    chomp;
    s/\r//g;
    next if(/^WEBVTT/);
    next if(/X-TIMESTAMP/);
    next if(!$expecting && /^$/);
    if(/(\d{2}:\d{2}:\d{2}\.\d{3}) --> \d{2}:\d{2}:\d{2}\.\d{3}/) {
        $newkey = $1;
        $expecting = 1;
        $text =~ s/  +/ /g;
        $vtt{$key} = $text;
        $key = $newkey;
        $text = '';        
    } else {
        if($text eq '') {
            $text = $_;
        } else {
            $text .= " $_";
        }
    }
}

my $previd = '';
my $line = 0;
while(<IN>) {
    chomp;
    $line++;
    next if(/^#/);
    my @pieces = split/\t/;
    if($#pieces == 1 && $pieces[1] eq 'd') {
        delete $vtt{$pieces[0]};
        $previd = '';
    } elsif($#pieces == 2 && $pieces[1] eq 's') {
        my $tmp = $vtt{$pieces[0]};
        my $split = quotemeta($pieces[2]);
        my @prts = split/$split/, $tmp;
        for (my $i = 0; $i <= $#prts; $i++) {
            my $id = $pieces[0] . "-" . ($i + 1);
            $vtt{$id} = $prts[$i];
        }
        delete $vtt{$pieces[0]};
        # Deliberately not updating $previd; 'merge with previous' doesn't want this
    } elsif($pieces[1] eq 'mp') {
        if($previd eq '') {
            die "previd unset";
        }
        my $text = $vtt{$id};
        if($#pieces > 1) {
            for(my $i = 2; $i <= $#pieces; $i += 2) {
                my $what = quotemeta($pieces[$i]);
                my $with = '';
                if($i == $#pieces && $#pieces % 2 != 1) {
                    $with = '';
                } else {
                    $with = $pieces[$i + 1];
                }
                $text =~ s/$what/$with/g;
            }
        } else {
        $vtt{$previd} .= " $vtt{$text}";
        delete $vtt{$pieces[0]};
    } else {
        if($#pieces < 3) {
            die "Error on line $line: $_\n";
        }
        my $id = $pieces[0];
        my $text = $vtt{$id};
        my $speaker = $pieces[1];
        my $start = $pieces[2];
        my $end = $pieces[3];
        if($#pieces > 3) {
            for(my $i = 4; $i <= $#pieces; $i += 2) {
                my $what = quotemeta($pieces[$i]);
                my $with = '';
                if($i == $#pieces && $#pieces % 2 != 1) {
                    $with = '';
                } else {
                    $with = $pieces[$i + 1];
                }
                $text =~ s/$what/$with/g;
            }
        }
        $vtt{$id} = $text;
        $previd = $id;
        $starts{$id} = $start;
        $ends{$id} = $end;
    }
}

for my $s (sort { $vtt{$a} <=> $vtt{$b} } keys %vtt) {
    print "$s: $starts{$s} $ends{$s} $vtt{$s}\n";
}
