#!/usr/bin/perl
# Scrapes the (relatively) new version of the vifax site
# dumps a list of urls for feeding into wget

use warnings;
use strict;
use utf8;

use URI;
use Web::Scraper;
use Data::Dumper;

my %seen = ();

my $menu = scraper {
    process 'div[class="menu-cartlann-container"] ul li ul li a', 'pages[]' => '@href';
};

my $videos = scraper {
    process 'table tbody tr td table tbody tr', 'videos[]' => scraper {
        process 'td div[class="wp-video"] video a', 'video' => '@href';
        process 'td a[onclick]', 'pdfs[]' => '@href';
    };
};
my $videos2 = scraper {
    process 'table tbody tr', 'videos[]' => scraper {
        process 'td div[class="wp-video"] video a', 'video' => '@href';
        process 'td a[onclick]', 'pdfs[]' => '@href';
    };
};

my $mainpage = URI->new('http://vifax.maynoothuniversity.ie/');
my $curyear = URI->new('http://vifax.maynoothuniversity.ie/an-bhliain-acaduil-seo/');

my $res = $menu->scrape($mainpage);

process_page($curyear);
for my $i (@{$res->{'pages'}}) {
    process_page($i);
}

sub process_page {
    my $uri = shift;
    my $pres;
    if($uri->as_string !~ m!/cartlann/!) {
        $pres = $videos->scrape($uri);
    } else {
        $pres = $videos2->scrape($uri);
    }
    for my $i (@{$pres->{'videos'}}) {
        my $vid = $i->{'video'}->as_string;
        next if(exists $seen{$vid});
        print "$vid\n";
        $seen{$vid} = 1;
        for my $j (@{$i->{'pdfs'}}) {
            next if($j->as_string =~ /bun.pdf$/);
            if($j->as_string =~ /TITLE/) {
                my $corr = $j->as_string;
                $corr =~ s/ME%C3%81NLEIBH%C3%89AL_DOC_TITLE_mean/20101123mean/;
                print "$corr\n";
                next;
            }
            print "$j\n";
        }
    }
}