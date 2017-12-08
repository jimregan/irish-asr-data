#!/usr/bin/perl
# Copyright (c) 2017 Jim O'Regan
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

use warnings;
use strict;
use utf8;

use URI;
use Web::Scraper;
use Encode;
use Data::Dumper;

binmode(STDOUT, ":utf8");

my $index_scraper = scraper {
    process '//ul', 'spans[]' => scraper {
        process 'li', 'items[]' => scraper {
                process 'a', 'link' => '@href';
        };
    };
};

#my $index = URI->new("https://www.scss.tcd.ie/~uidhonne/comhra/index.utf8.html");

#my $idxres = $index_scraper->scrape($index);

#my @pages = ();

#for my $span (@{$idxres->{'spans'}}) {
#    for my $item (@{$span->{'items'}}) {     
#            if(exists $item->{'link'} && $item->{'link'} =~ m!/comhra/!) {
#                push @pages, $item->{'link'};
#            }
#    }
#}

my $content_scraper = scraper {
    process '//script[contains(text(),"mp3:"]', 'script' => 'TEXT';
    process '//div[@id = "text"]', 'text' => scraper {
        process 'dl', 'chunk[]' => scraper {
            process 'dt', 'speaker' => 'TEXT';
            process 'dd', 'segments[]' => scraper {
                process 'p', 'start' => '@start';
                process 'p', 'end' => '@end';
                process 'p', 'text' => 'TEXT';
            };
        };
    };
};

my $page = URI->new("https://www.scss.tcd.ie/~uidhonne/comhra/irgl0001.utf8.html");
my $res = $content_scraper->scrape($page);
print Dumper $res;