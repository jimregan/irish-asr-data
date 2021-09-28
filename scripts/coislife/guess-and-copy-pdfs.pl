#!/usr/bin/perl
# Checks a directory for the input files

use Digest::MD5::File qw(file_md5_base64);
use File::Copy;
use Data::Dumper;

if (!@ARGV) {
	die "Usage: guess-and-copy-pdfs.pl [path to pdfs] [output directory]\n";
}
my $PATH=$ARGV[0];
my $OPATH=$ARGV[1];

if ( ! -d $OPATH ) {
	mkdir($OPATH);
}

my %copyto = (
	"njtGr95vD0p8ArHEb3P87A" => "an_tiriseoir_c1.pdf",
	"8hMPtwGuxaf4hKqxim6qDA" => "i_dtir_mhilis_na_mbeo_c1.pdf",
	"JDQ2kDJjz1vr1ecGGpbRCA" => "ibiotsa_c1.pdf",
	"zZQnJOpzfv0uo8ZzX5Hy5A" => "an_fuioll_feа.pdf",
	"pOz/E4O0xdcng8J5Has31A" => "an_tiriseoir.pdf",
	"ietyOTxZ+WaTUj58s1sXWA" => "aois_fir.pdf",
	"UJOe+lwqfemMJPiCk3ahDw" => "daideo.pdf",
	"GwwBowDZBf9x1U2FNR3Rag" => "hata_zu_mhamo.pdf",
	"5svNyA0mgyeSHqARGSoOAQ" => "i_dtir_mhilis_na_mbeo.pdf",
	"CDMl7JTX9qiy5pW8ntvcgQ" => "oilithreach_pinn.pdf",
	"ofMD2a3OCpd6SKgcym9WkA" => "seadna.pdf",
	"/AEmvzuYC0/tapNWlfPoog" => "ulla.pdf",
	"+U2JjZcFtyPivI3DmfwxOw" => "ibiotsa.pdf",
);

my %seen = ();

opendir(DIR, $PATH);
my @files = readdir(DIR);
closedir(DIR);
if($PATH =~ /\/$/) {
	$PATH =~ s/\/$//;
}

for my $file (@files) {
	next if($file eq '.' || $file eq '..' || $file =~ /^\./);
	my $infile = "$PATH/$file";
	my $digest = file_md5_base64("$infile");
	if(!exists $seen{$digest}) {
		$seen{$digest} = $file;
	} else {
		print "Skipping: $file is a copy of $seen{$digest}\n";
		next;
	}
#	print "\t\"$digest\" => \"$file\",\n";
	my $outfile = "$OPATH/$copyto{$digest}";
	copy($infile, $outfile) or die "$!";
}
