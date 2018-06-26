#!/usr/bin/perl
# Checks a directory for the input files

use Digest::MD5::File qw(file_md5_base64);
use File::Copy;
use Data::Dumper;

if (!@ARGV) {
	die "Usage: guess-and-copy-pdfs.pl [path to pdfs]\n";
}
my $PATH=$ARGV[0];

my %copyto = (
	"njtGr95vD0p8ArHEb3P87A" => "an_tiriseoir_c1.pdf",
	"8hMPtwGuxaf4hKqxim6qDA" => "i_dtir_mhilis_na_mbeo_c1.pdf",
	"JDQ2kDJjz1vr1ecGGpbRCA" => "ibiotsa_c1.pdf",
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
	my $outfile = "$PATH/$copyto{$digest}";
	copy($infile, $outfile) or die "$!";
}
