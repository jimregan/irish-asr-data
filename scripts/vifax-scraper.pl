#!/usr/bin/perl
# Scrapes the (relatively) new version of the vifax site

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
    process 'table tbody tr', 'videos[]' => scraper {
        process 'td div[class="wp-video"] div div div video', 'video' => '@src';
        process 'td a', 'pdfs[]' => '@href';
    };
};

my $mainpage = URI->new('http://vifax.maynoothuniversity.ie/');
my $curyear = URI->new('http://vifax.maynoothuniversity.ie/an-bhliain-acaduil-seo/');

my $res = $menu->scrape($mainpage);

print Dumper $curyear;
process_page($curyear);

sub process_page {
    my $uri = shift;
    my $pres = $videos->scrape($uri);
    print Dumper $pres;
}