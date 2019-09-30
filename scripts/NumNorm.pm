package Numbers;

use warnings;
#use strict;
use utf8;

use Exporter;

our @ISA = qw/Exporter/;
our @EXPORT = qw/make_definite mkord/;

sub make_definite {
	shift if($_[0] eq 'make_definite');
	my $in = shift;
	if($in =~ /^[aeiouAEIOUáéíóúÁÉÍÓÚ]/) {
		$in = "t-$in";
	} elsif ($in eq 'céad') {
		$in = "chéad";
	}
	$in;
}

sub mkord {
	shift if($_[0] eq 'mkord');
	return join (' ', mkord_inner($_[0]));
}

sub mkord_inner {
	my $num = shift;
	my @ret = ();

	my %ords = (
		1 => 'aonú',
		2 => 'dóú',
		3 => 'tríú',
		4 => 'ceathrú',
		5 => 'cúigiú',
		6 => 'séú',
		7 => 'seachtú',
		8 => 'ochtú',
		9 => 'naoú',
		10 => 'deichiú',
		20 => 'fichiú',
		30 => 'tríochadú',
		40 => 'daicheadú',
		50 => 'caogadú',
		60 => 'seascadú',
		70 => 'seachtódú',
		80 => 'ochtódú',
		90 => 'nóchadú',
		100 => 'céadú',
		200 => 'dá chéadú',
		300 => 'trí chéadú',
		400 => 'ceithre chéadú',
		500 => 'cúig chéadú',
		600 => 'sé chéadú',
		700 => 'seacht gcéadú',
		800 => 'ocht gcéadú',
		900 => 'naoi gcéadú',
	);
	if($num eq '1' || $num eq '1d' || $num eq '1ad') {
		return ('céad');
	}
	if($num eq '2' || $num eq '2a' || $num eq '2ra') {
		return ('dara');
	}
	if($num =~ /([0-9]+)(ú|adh)?/) {
		$num = $1;
		if(exists $ords{$num}) {
			return ($ords{$num});
		}
	} else {
		return @ret;
	}
}

# super simple mutation, because the words are fixed
sub lenite {
	shift if($_[0] eq 'lenite');
	my $word = shift;
	if($word =~ /^([bcdfgmpst])(.*)$/) {
		return "$1h$2";
	} else {
		return $word;
	}
}
sub eclipse {
	shift if($_[0] eq 'eclipse');
	my $word = shift;
	my %ecl = (
		'a' => 'n-',
		'á' => 'n-',
		'b' => 'm',
		'c' => 'g',
		'd' => 'n',
		'e' => 'n-',
		'é' => 'n-',
		'f' => 'bh',
		'g' => 'n',
		'i' => 'n-',
		'í' => 'n-',
		'o' => 'n-',
		'ó' => 'n-',
		'p' => 'b',
		't' => 'd',
		'u' => 'n-',
		'ú' => 'n-',
	);
	my $first = substr($word, 0, 1);
	if(exists $ecl{$first}) {
		return $ecl{$first} . $word;
	} else {
		return $word;
	}
}

unless (caller) {
    use Encode qw(decode_utf8);
    @ARGV = map { decode_utf8($_, 1) } @ARGV;
    binmode(STDIN, ":utf8");
    binmode(STDOUT, ":utf8");
    print shift->(@ARGV) . "\n";
}
1;
