#!/usr/bin/perl
# https://www.brendanlong.com/the-structure-of-an-mpeg-dash-mpd.html
# https://www.senat.gov.pl/prace/senat/posiedzenia/

use warnings;
use strict;
use utf8;

use LWP::Simple;
use JSON;
use HTTP::Request;
use LWP::UserAgent;
use Data::Dumper;

my $id = $ARGV[0];

my $MAGIC = '978307200000';

my $url_template = "https://av8.senat.pl/senat-console/side-menu/transmissions/$id/vod";

my $raw = get($url_template);
my $base_json = decode_json($raw);

my $cfg = decode_json(get("https://av8.senat.pl/senat-console/side-menu/transmissions/$id/vod/player-configuration"));
my $base_url = $cfg->{'player'}->{'playlist'}->{'dash'};

my $from = $base_json->{'since'} - $MAGIC;
my $to =  $base_json->{'till'} - $MAGIC;
my $index_url = "https:$base_url&startTime=$from&stopTime=$to";

my $req = HTTP::Request->new(GET => $index_url);
$req->header('Sec-Fetch-Mode' => 'cors', 
             'Referer' => "https://av8.senat.pl/$id", 
             'Origin' => 'null',
             'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36',
             'DNT' => '1');
my $agent = LWP::UserAgent->new();
my $response = $agent->request($req);
my $uri = $response->{'_request'}->{'_uri'};
print "$uri\n\n";
$req->uri($uri);
print Dumper $agent->request($req);

# MESSAGES
# https://av8.senat.pl/senat-console/side-menu/transmissions/9Sen771/vod/board-messages

