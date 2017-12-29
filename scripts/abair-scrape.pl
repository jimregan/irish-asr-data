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
use URI::file;
use Web::Scraper;
use Encode;
use Data::Dumper;

binmode(STDOUT, ":utf8");

my $articles = scraper {
        process '//table[@class="transcription"]', 'elems[]' => scraper {
                process '//tr[3]/td[1]', 'text' => 'TEXT';
                process '//tr[3]/td[2]', 'trans' => 'TEXT';
        };
};

my $file = URI::file->new("/tmp/htmout");

my $res = $articles->scrape($file);

for my $elem (@{$res->{'elems'}}) {
    my $text = $elem->{'text'};
    my $pron = $elem->{'trans'};

    $pron =~ s/\N{U+00a0}/ /g;
    $pron =~ s/0 //g;
    $pron =~ s/1 +/ˈ /g;
    $pron =~ s/2 /ˌ /g;
    $pron =~ s/ \. / /g;
    $pron =~ s/ $//;
    $pron =~ s/^[ \t]*//;
    print "$text\t$pron\n";
}
