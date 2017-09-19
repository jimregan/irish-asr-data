#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

my %norm = (
    '’á' => 'á',
    'd’aoís' => "d'aois",
    'tighearna' => 'tiarna',
    'sgéal' => 'scéal',
    'd’á' => 'dá',
    'd’ár' => 'dár',
    'de’n' => 'den',
    'airís' => 'arís',
    'h-Éirean' => 'hÉireann',
    'caithte' => 'caite',
    'h-Éirinn' => 'hÉirinn',
    'n-Éirinn' => 'nÉirinn',
    'cómhnuighe' => 'cónaí',
    'chómnuighe' => 'chónaí',
    'chómhnuighe' => 'chónaí',
    'gcómhnuighe' => 'gcónaí',
    'do’n' => 'don',
    'breágh' => 'breá',
    'ó’n' => 'ón',
    'ainim' => 'ainm',
    'orm-sa' => 'ormsa',
    'eadh' => 'ea',
    'Ghaedhlaibh' => 'Ghaelaibh',
    'Nuadhat' => 'Nuad',
    'agam-sa' => 'agamsa',
    'má’s' => 'más',
    'ní’l' => 'níl',
    'Seághan' => 'Seán',
    't-eólus' => 't-eolas',
    'sgoil' => 'scoil',
    'sgrúdughadh' => 'scrúdú',
    'gcoláisde' => 'gcoláiste',
    'máighistir' => 'máistir',
    'sgéal' => 'scéal',
    'sglábhaidheachta' => 'sclábhaíochta',
    'd’innis' => "d'inis",
    'd’árduigh' => "d'ardaigh",
    'd’eirigh' => "d'éirigh",
    'd’imthigh' => "d'imigh",
    'd’iompuigh' => "d'iompaigh",
    'd’aireófá' => "d'aireofá",
    'd’fheuch' => "d'fhéach",
    'd’iompuigheadar' => "d'iompaíodar",
    'Séadha' => 'Sé',
    'dóich' => 'dóigh',
    '’n-a' => 'ina',
    'théidhinn' => 'théinn',
#    'lastiar' => 'laistiar',
    'mhuíntir' => 'mhuintir',
    'géana' => 'géanna',
    'sgafaire' => 'scafaire',
    'beithigheach' => 'beithíoch',
    'sgannradh' => 'scanradh',
    'gcroídhe' => 'gcroí',
    'chroidhe-se' => 'chroíse',
    'chínn' => 'chinn',
    'buidhe' => 'buí',
    'león' => 'leon',
#    'aoirde' => 'airde',
    'sheasuigheadh' => 'sheasadh',
    'bitheamhnach' => 'bithiúnach',
    'chómh' => 'chomh',
    'ortha' => 'orthu',
    'sgáth' => 'scáth',
    'caraige' => 'carraige',
    '’ná' => 'ná',
    'sgaoil' => 'scaoil',
    "bosga" => "bosca",
    "chosg" => "chosc",
    "dhísgiughadh" => "dhísciú",
    "dh’fheisgint" => "d'fheiscint",
    "feisgint" => "feiscint",
    "léirsgrios" => "léirscrios",
    "measg" => "measc",
    "measgán" => "meascán",
    "neamhsgáthmhar" => "neamhscáfar",
    "ngaisge" => "ngaisce",
    "osgailt" => "oscailt",
    "osguil" => "oscail",
    "phléasgamair" => "phléascamar",
    "sgaoileadh" => "scaoileadh",
    "sgar" => "scar",
    "sgaradh" => "scaradh",
    "sgeithe" => "sceithe",
    "sgeón" => "sceon",
    "sgiain" => "scian",
    "sgian" => "scian",
    "sgiathóige" => "sciathóige",
    "sgiúradh" => "sciúradh",
    "sgoile" => "scoile",
    "sgoileana" => "scoileanna",
    "sgoilfeadh" => "scoiltfeadh",
    "sgolaidheachta" => "scolaíochta",
    "sgoláirí" => "scoláirí",
    "sgrannradh" => "scranradh",
    "sgreadach" => "screadach",
    "sgreadaigh" => "screadaigh",
    "sgriosadh" => "scriosadh",
    "sgríbhinn" => "scríbhinn",
    "sguabadar" => "scuabadar",
    "sgurtha" => "scortha",
    "sgéalta" => "scéalta",
    "sgéil" => "scéil",
    "teagasg" => "teagasc",
    "thuisgint" => "thuiscint",
    "toirmeasg" => "toirmeasc",
    "toisg" => "toisc",
    "tuairisg" => "tuairisc",
    "tuisgint" => "tuiscint",
    "túisge" => "túisce",
    "uisge-fé-thalamh" => "uisce fé thalamh",
    "choláisde" => "choláiste",
    "coláisde" => "coláiste",
    "cosdais" => "costais",
    "críosdaidhe" => "críostaí",
    "lóisdín" => "lóistín",
    "mhisde" => "mhiste",
    "bhuidhe" => "bhuí",
    "chlaidhe" => "chlaí",
    "claidhe" => "claí",
    "críostaidhe" => "críostaí",
#    "dtineóntaidhe" => "dtionóntaí",
    "garaidhe" => "garraí",
    "gharaidhe" => "gharraí",
    "mbuidhe" => "mbuí",
    "mearaidhe" => "mearaí",
    "ngaraidhe" => "ngarraí",
    "réidhe" => "ré",
    "shuidhe" => "shuí",
    "suidhe" => "suí",
    "theasaidhe" => "theasaí",
    "thineóntaidhe" => "thionóntaí",
    "tineóntaidhe" => "tionóntaí",
    "dlíghe" -> "dlí",
    "d'á" -> "dá",
    "sínsear" -> "sinsear",
    "h-éagcóra" -> "héagóra",
    "eirighe" -> "éirí",
    "iaracht" -> "iarracht",
    "bheartughadh" -> "bheartú",
    "iseadh" -> "is ea",
    "adúbhairt", "a dúirt",
    "ó-thuaidh", "ó thuaidh",
    "chuaidh" -> "chuaigh",
    "dhiaigh" -> "dhiaidh",
    "adtuaidh" => "aduaidh",
    "adúbhairt" => "a dúirt",
    "adúbhart" => "a dúirt",
    "aedhreacht" => "aeraíocht",
    "agaibh-se" => "agaibhse",
    "agam-sa" => "agamsa",
);

while(<>) {
    chomp;
    s/\./ ./g;
    s/“/“ /g;
    s/,/ ,/g;
    s/”/ ”/g;
    s/!/ !/g;
    s/\?/ ?/g;

    s/\bi n-aice /in aice /g;
    s/\ble n-a /lena /g;
    s/\b[Gg]ur ?bh’ ?/gurbh /g;
    s/\b[Gg]ur ?b’ ?/gurb /g;
    s/\b[Nn]ár bh’ ?/nárbh /g;
    s/\b[Dd]ár bh’ ?/dárbh /g;
    s/\b[Cc]ár bh’ ?/cárbh /g;
    s/\b[Nn]íor bh’ ?/níorbh /g;
    s/\bníb’ /níb'/g;
    s/\bmb’ fhéidir\b/mb'fhéidir/g;
    s/\bb’ fhéidir\b/b'fhéidir/g;
    s/\bm’ /m'/g;
    s/\bd’ /d'/g;
    s/\b[Cc]é ’r bh’ ?/cérbh /g;
    s/\bi n-aon /in aon/g;
    s/b’ /b'/g;
    s/i n-Éirinn/in Éirinn/g;
    s/’/'/g;

    for my $word (split/ /) {
        my $lcword = irishlc($word);
        if (exists $norm{$word}) {
            print $norm{$word} . " ";
        } elsif (exists $norm{$lcword}) {
            print $norm{$lcword} . " ";
        } else {
            print "$lcword ";
        }
    }
    print "\n";
}

sub irishlc {
    my $word = shift;
    $word =~ s/([nt])([AEIOUÁÉÍÓÚ])/$1-$2/;
    return lc($word);
}
