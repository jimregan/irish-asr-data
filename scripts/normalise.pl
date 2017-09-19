#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

my %norm = (
    "'á" => "á",
    "adtuaidh" => "aduaidh",
    "adúbhairt" => "a dúirt",
    "adúbhairt", "a dúirt",
    "adúbhart" => "a dúirt",
    "aedhreacht" => "aeraíocht",
    "agaibh-se" => "agaibhse",
    "agam-sa" => "agamsa",
    "aici-si" => "aicisí",
    "aige-sean" => "aigesean",
    "ainiar" => "aniar",
    "ainim" => "ainm",
    "ainíos" => "aníos",
    "airigheadar" => "airíodar",
    "airís" => "arís",
    "amuich" => "amuigh",
    "amus" => "amas",
    "anáirde" => "in airde",
#    'aoirde' => 'airde',
    "asta" => "astu",
    "atúrnae" => "aturnae",
    "bailighthe" => "bailithe",
    "baoghal" => "baol",
    "bárr" => "barr",
    "beithigheach" => "beithíoch",
    "beó" => "beo",
    "bhaoghal" => "bhaol",
    "bhárr" => "bharr",
    "bheartughadh" -> "bheartú",
    "bhreagh" => "bhreá",
    "bhreóiteachtaí" => "bhreoiteachtaí",
    "bhreóiteacht" => "bhreoiteacht",
    "bhrígh" => "bhrí",
    "bhrúth" => "bhrú",
    "bhuidhe" => "bhuí",
    "bitheamhnach" => "bithiúnach",
    "bosga" => "bosca",
    "bpoibilidheacht" => "bpoiblíocht",
    "bpúnc" => "bponc",
    "breagh" => "breá",
    "breágh" => "breá",
    "breaghtha" => "breátha",
    "breithniughadh" => "breathnú",
    "breóiteacht" => "breoiteacht",
    "brígh" => "brí",
    "bríghe" => "brí",
    "bríoghmhar" => "bríomhar",
    "brúth" => "brú",
    'buidhe' => 'buí',
    'caithte' => 'caite',
    'caraige' => 'carraige',
    "charaig" => "charraig",
    'chínn' => 'chinn',
    "chlaidhe" => "chlaí",
    "chnuc" => "chnoc",
    "chnuic" => "chnoic",
    "choláisde" => "choláiste",
    'chómh' => 'chomh',
    'chómhnuighe' => 'chónaí',
    'chómnuighe' => 'chónaí',
    "chosg" => "chosc",
    'chroidhe-se' => 'chroíse',
    "chuaidh" -> "chuaigh",
    "claidhe" => "claí",
    "cleasaidheacht" => "cleasaíocht",
    "codla" => "codladh",
    "coigcríoch" => "coigríoch",
    "coláisde" => "coláiste",
    "cómhluadar" => "comhluadar",
    "cómhnuighe" => "cónaí",
    "cosdais" => "costais",
    "críosdaidhe" => "críostaí",
    "críostaidhe" => "críostaí",
    "d'á" -> "dá",
    "d'aireófá" => "d'aireofá",
    "d'aoís" => "d'aois",
    "d'ár" => "dár",
    "d'árduigh" => "d'ardaigh",
    "deifrigheacht" => "difríocht",
    "d'eileamh" => "d'éileamh",
    "deimhnightheach" => "deimhneach",
    "d'eirigh" => "d'éirigh",
    "de'n" => "den",
    "d'fheuch" => "d'fhéach",
    "dhéanfaimíd" => "dhéanfaimid",
    "dhearbhuigh" => "dhearbhaigh",
    "dh'fheisgint" => "d'fheiscint",
    "dhiaigh" -> "dhiaidh",
    "dhísgiughadh" => "dhísciú",
    "d'imthigh" => "d'imigh",
    "d'innis" => "d'inis",
    "d'iompuigh" => "d'iompaigh",
    "d'iompuigheadar" => "d'iompaíodar",
    "dlíghe" -> "dlí",
    'dóich' => 'dóigh',
    "do'n" => "don",
#    "dtineóntaidhe" => "dtionóntaí",
    'eadh' => 'ea',
    "eirighe" -> "éirí",
    "feisgint" => "feiscint",
    "garaidhe" => "garraí",
    'gcoláisde' => 'gcoláiste',
    'gcómhnuighe' => 'gcónaí',
    'gcroídhe' => 'gcroí',
    'géana' => 'géanna',
    'Ghaedhlaibh' => 'Ghaelaibh',
    "gharaidhe" => "gharraí",
    "h-éagcóra" -> "héagóra",
    'h-Éirean' => 'hÉireann',
    'h-Éirinn' => 'hÉirinn',
    "iaracht" -> "iarracht",
    "iseadh" -> "is ea",
#    'lastiar' => 'laistiar',
    "léirsgrios" => "léirscrios",
    'león' => 'leon',
    "lóisdín" => "lóistín",
    'máighistir' => 'máistir',
    "má's" => "más",
    "mbuidhe" => "mbuí",
    "mearaidhe" => "mearaí",
    "measgán" => "meascán",
    "measg" => "measc",
    "mhisde" => "mhiste",
    'mhuíntir' => 'mhuintir',
    "'n-a" => "na",
    "'ná" => "ná",
    "neamhsgáthmhar" => "neamhscáfar",
    'n-Éirinn' => 'nÉirinn',
    "ngaisge" => "ngaisce",
    "ngaraidhe" => "ngarraí",
    "ní'l" => 'níl',
    'Nuadhat' => 'Nuat',
    "ó'n" => "ón",
    'orm-sa' => 'ormsa',
    'ortha' => 'orthu',
    "osgailt" => "oscailt",
    "osguil" => "oscail",
    "ó-thuaidh", "ó thuaidh",
    "phléasgamair" => "phléascamar",
    "réidhe" => "ré",
    'Séadha' => 'Sé',
    'Seághan' => 'Seán',
    'sgafaire' => 'scafaire',
    'sgannradh' => 'scanradh',
    "sgaoileadh" => "scaoileadh",
    'sgaoil' => 'scaoil',
    "sgaradh" => "scaradh",
    "sgar" => "scar",
    'sgáth' => 'scáth',
    'sgéal' => 'scéal',
    "sgéalta" => "scéalta",
    "sgéil" => "scéil",
    "sgeithe" => "sceithe",
    "sgeón" => "sceon",
    "sgiain" => "scian",
    "sgian" => "scian",
    "sgiathóige" => "sciathóige",
    "sgiúradh" => "sciúradh",
    'sglábhaidheachta' => 'sclábhaíochta',
    "sgoileana" => "scoileanna",
    "sgoile" => "scoile",
    "sgoilfeadh" => "scoiltfeadh",
    'sgoil' => 'scoil',
    "sgolaidheachta" => "scolaíochta",
    "sgoláirí" => "scoláirí",
    "sgrannradh" => "scranradh",
    "sgreadach" => "screadach",
    "sgreadaigh" => "screadaigh",
    "sgríbhinn" => "scríbhinn",
    "sgriosadh" => "scriosadh",
    'sgrúdughadh' => 'scrúdú',
    "sguabadar" => "scuabadar",
    "sgurtha" => "scortha",
    'sheasuigheadh' => 'sheasadh',
    "shuidhe" => "shuí",
    "sínsear" -> "sinsear",
    "suidhe" => "suí",
    "teagasg" => "teagasc",
    't-eólus' => 't-eolas',
    "theasaidhe" => "theasaí",
    'théidhinn' => 'théinn',
    "thineóntaidhe" => "thionóntaí",
    "thuisgint" => "thuiscint",
    'tighearna' => 'tiarna',
    "tineóntaidhe" => "tionóntaí",
    "toirmeasg" => "toirmeasc",
    "toisg" => "toisc",
    "tuairisg" => "tuairisc",
    "túisge" => "túisce",
    "tuisgint" => "tuiscint",
    "uisge-fé-thalamh" => "uisce fé thalamh",
);

while(<>) {
    chomp;
    s/\./ ./g;
    s/“/“ /g;
    s/,/ ,/g;
    s/”/ ”/g;
    s/!/ !/g;
    s/\?/ ?/g;

    s/\bi n-aice /in aice /gi;
    s/\ble n-a /lena /gi;
    s/\b[Gg]ur ?bh’ ?/gurbh /gi;
    s/\b[Gg]ur ?b’ ?/gurb /gi;
    s/\b[Nn]ár bh’ ?/nárbh /gi;
    s/\b[Dd]ár bh’ ?/dárbh /gi;
    s/\b[Cc]ár bh’ ?/cárbh /gi;
    s/\b[Nn]íor bh’ ?/níorbh /gi;
    s/\bníb’ /níb'/gi;
    s/\bmb’ fhéidir\b/mb'fhéidir/gi;
    s/\bb’ fhéidir\b/b'fhéidir/gi;
    s/\bm’ /m'/gi;
    s/\bd’ /d'/gi;
    s/\b[Cc]é ’r bh’ ?/cérbh /gi;
    s/\bi n-aon /in aon/gi;
    s/\b’dh eadh/dhea/gi;
    s/\bb’ /b'/gi;
    s/i n-Éirinn/in Éirinn/gi;
    s/\bana bheag/an-bheag/gi;
    s/\bana mhaith/an-mhaith/gi;
    s/\bana mhór/an-mhór/gi;
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
