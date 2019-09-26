#!/usr/bin/perl
# Scrapes the (relatively) new version of the vifax site

use warnings;
use strict;
use utf8;

use URI;
use Web::Scraper;
use Data::Dumper;

my $menu = scraper {
#    process 'div[class="menu-cartlann-container"] ul[class="top-menu"] li#"menu-item-64" ul[class="sub-menu"] li a', 'pages[]' => '@href';
    process 'div[class="menu-cartlann-container"] ul li ul li a', 'pages[]' => '@href';
};

my $res = $menu->scrape(URI->new('http://vifax.maynoothuniversity.ie/'));

print Dumper $res;