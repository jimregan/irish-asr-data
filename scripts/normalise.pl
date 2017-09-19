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
    "aici-si" => "aicisí",
    "aige-sean" => "aigesean",
    "ainiar" => "aniar",
    "ainim" => "ainm",
    "ainíos" => "aníos",
    "airigheadar" => "airíodar",
    "amuich" => "amuigh",
    "amus" => "amas",
    "ana bheag" => "an-bheag",
    "anáirde" => "in airde",
    "ana mhaith" => "an-mhaith",
    "ana mhór" => "an-mhór",
    "asta" => "astu",
    "atúrnae" => "aturnae",
    "bailighthe" => "bailithe",
    "baoghal" => "baol",
    "bárr" => "barr",
    "beithigheach" => "beithíoch",
    "beó" => "beo",
    "bhaoghal" => "bhaol",
    "bhárr" => "bharr",
    "bhreagh" => "bhreá",
    "bhreóiteachtaí" => "bhreoiteachtaí",
    "bhreóiteacht" => "bhreoiteacht",
    "bhrígh" => "bhrí",
    "bhrúth" => "bhrú",
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
    "charaig" => "charraig",
    "chnuc" => "chnoc",
    "chnuic" => "chnoic",
    "cleasaidheacht" => "cleasaíocht",
    "codla" => "codladh",
    "coigcríoch" => "coigríoch",
    "cómhluadar" => "comhluadar",
    "cómhnuighe" => "cónaí",
    "d'á" => "dá",
    "deifrigheacht" => "difríocht",
    "d'eileamh" => "d'éileamh",
    "deimhnightheach" => "deimhneach",
    "dhéanfaimíd" => "dhéanfaimid",
    "dhearbhuigh" => "dhearbhaigh",
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
