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
    "d'eirigheadar" => "d'éiríodar",
    "deirim-se" => "deirimse",
    "deisbhéalaighe" => "deisbhéalaí",
    "de'n" => "den",
    "deó" => "deo",
    "d'fhághail" => "d'fháil",
    "d'fheuch" => "d'fhéach",
    "d'fheuch" => "d'fhéach",
    "dhéanfaimíd" => "dhéanfaimid",
    "dhearbhuigh" => "dhearbhaigh",
#    "dh'fheisgint" => "d'fheiscint",
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
    "n'osguil" => "n'oscail",
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
#    'sheasuigheadh' => 'sheasadh',
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
    "t-ím" => "t-im",
    "tineóntaidhe" => "tionóntaí",
#    "tineóntaithe" => "tionóntaí",
    "tínteáin" => "tinteáin",
    "toirmeasg" => "toirmeasc",
    "toisg" => "toisc",
    "t-órd" => "t-ord",
    "toirmeasg" => "toirmeasc",
    "toisg" => "toisc",
    "tuairisg" => "tuairisc",
    "túisge" => "túisce",
    "tuisgint" => "tuiscint",
    "uisge-fé-thalamh" => "uisce fé thalamh",
    "úrláir" => "urláir",
    "úrlár" => "urlár",
    "sgrúdughadh" => "scrúdú",
    "sguabadar" => "scuabadar",
    "sgurtha" => "scortha",
    "sháidh" => "sháith",
    "shaothrughadh" => "shaothrú",
    "Shéadna" => "Shéanna",
    "Sheághain" => "Sheáin",
    "sheana-mháthair" => "sheanmháthair",
    "shean-athair" => "sheanathair",
    "sgéil" => "scéil",
    "sgeithe" => "sceiche",
    "sgeón" => "sceon",
    "staidhre" => "staighre",
    "stuamdha" => "stuama",
    "suidhe" => "suí",
    "suídhe" => "suí",
    "suidhfeadh" => "suífeadh",
    "sgafaire" => "scafaire",
    "sgannradh" => "scanradh",
    "sgaoileadh" => "scaoileadh",
    "sgaoil" => "scaoil",
    "sgaradh" => "scaradh",
    "sgar" => "scar",
    "sgáth" => "scáth",
    "sgéal" => "scéal",
    "sgéalta" => "scéalta",
    "sgiain" => "scian",
    "sgian" => "scian",
    "sgiathóige" => "sciathóige",
    "sgiúradh" => "sciúradh",
    "sglábhaidheachta" => "sclábhaíochta",
    "sgoileana" => "scoileanna",
    "sgoile" => "scoile",
    "sgoilfeadh" => "scoiltfeadh",
    "sgoil" => "scoil",
    "sgolaidheachta" => "scolaíochta",
    "sgoláirí" => "scoláirí",
    "sgreadach" => "screadach",
    "sgreadaigh" => "screadaigh",
    "sgríbhinn" => "scríbhinn",
    "sgriosadh" => "scriosadh",
    "shíothcháin" => "shíocháin",
    "shíothchánta" => "shíochánta",
    "shleamhnuigh" => "shleamhnaigh",
    "shlígh" => "shlí",
    "shocarughadh" => "shocrú",
    "shocaruigheadar" => "shocraíodar",
    "teagasg" => "teagasc",
    "t-eirighe" => "t-éirí",
    "t-éirleach" => "t-eirleach",
    "t-eólus" => "t-eolas",
    "t-é" => "té",
    "thagan" => "thagann",
    "tharaing" => "tharraing",
    "thárla" => "tharla",
    "theasaidhe" => "theasaí",
    "theastuigh" => "theastaigh",
    "dlígh" => "dlí",
    "dlíghe" => "dlí",
    "dlighthe" => "dlíthe",
    "dronnaighe" => "dronnaí",
    "dtreó" => "dtreo",
    "éagcóir" => "éagóir",
    "éagcóra" => "éagóra",
    "éalódh" => "éalú",
    "Eóghan" => "Eoghan",
    "eolus" => "eolas",
    "eólus" => "eolas",
    "Frainncise" => "Fraincise",
    "Frainncis" => "Fraincis",
    "Gaedhal" => "Gael",
    "Gaedhil" => "Gaeil",
    "Gaedhlacha" => "Gaelacha",
    "gáirdín" => "gairdín",
    "garaidhe" => "garraí",
    "garaidhthe" => "garraithe",
    "gasradh" => "gasra",
    "gcaithtear" => "gcaitear",
    "gcaraig" => "gcarraig",
    "gcnuc" => "gcnoc",
    "gcoláisde" => "gcoláiste",
    "gcómhaireamh" => "gcomhaireamh",
    "gcómhnuighe" => "gcónaí",
    "ghrádhmhar" => "ghrámhar",
    "ghrána" => "ghránna",
    "ghuna" => "ghunna",
    "glaodhach" => "glaoch",
    "glaoidhte" => "glaoite",
    "gurbh'" => "gurbh",
    "h-áite" => "háite",
    "h-áit" => "háit",
    "h-aithbhliana" => "hathbhliana",
    "h-áluinn" => "hálainn",
    "h-amháin" => "hamháin",
    "h-ana" => "hana",
    "h-anam" => "hanam",
    "h-aon" => "haon",
    "h-árduigheadh" => "hardaíodh",
    "h-athair" => "hathair",
    "h-athar" => "hathar",
    "h-eadh" => "hea",
    "h-éagcóra" => "héagóra",
    "h-éagcruas" => "héagruas",
    "h-éiligheadh" => "héilíodh",
    "h-Éirean" => "hÉireann",
    "h-Éirinn" => "hÉirinn",
    "h-éitheach" => "héitheach",
    "h-Icídhe" => "hIcí",
    "h-oídhche" => "hoíche",
    "h-olc" => "holc",
    "h-ollamh" => "hullamh",
    "h-uathbhás" => "huafás",
    "h-udhacht" => "huacht",
    "iaracht" => "iarracht",
    "iaraidh" => "iarraidh",
    "Icídhe" => "Icí",
    "h-uaire" => "huaire",
    "h-uair" => "huair",
    "h-uaisle" => "huaisle",
    "imigcéineamhla" => "imigéiniúla",
    "imigéineamhla" => "imigéiniúla",
    "ím" => "im",
    "imtheacht" => "imeacht",
    "iseadh" => "is ea",
    "isé" => "is é",
    "leath-sgéal" => "leithscéal",
    "leath-sgéil" => "leithscéil",
    "liúgh" => "liú",
    "lóisdín" => "lóistín",
    "lúgha" => "lú",
    "Lughnasa" => "Lúnasa",
#    "Maghchromtha" => "Maigh Chromtha",
    "máighistir" => "máistir",
    "mairean" => "maireann",
    "maoidheamh" => "maíomh",
    "marbhughadh" => "marú",
    "marbhuigheadh" => "maraíodh",
    "marcaidheacht" => "marcaíocht",
    "má's" => "más",
    "m'athair-se" => "m'athairse",
    "mbádhfaí" => "mbáfaí",
    "mbórd" => "mbord",
    "mbrígh" => "mbrí",
    "mbuidhe" => "mbuí",
    "mearaidhe" => "mearaí",
    "measgán" => "meascán",
    "measg" => "measc",
    "meathlughadh" => "meathlú",
    "me" => "mé",
    "mhaidean" => "mhaidin",
    "mháighistir" => "mháistir",
    "nách" => "nach",
    "n-achran" => "n-achrann",
    "nách" => "nach",
    "n-achran" => "n-achrann",
    "n-Aifric" => "nAifric",
    "nGaedhal" => "nGael",
    "ngaisge" => "ngaisce",
    "ngaraidhe" => "ngarraí",
    "ngioracht" => "ngiorracht",
    "níba" => "ní ba",
    "ó'n" => "ón",
    "órd" => "ord",
    "orm-sa" => "ormsa",
    "osgailt" => "oscailt",
    "osguil" => "oscail",
    "ó-thuaidh" => "ó thuaidh",
    "saidhbhir" => "saibhir",
    "saidhbhreas" => "saibhreas",
    "sáidhte" => "sáite",
    "sailighe" => "sailí",
    "'á" => "á",
    "a'" => "a",
    "'ach" => "ach",
    "adéarfaidh" => "a déarfaidh",
    "adeirim" => "a deirim",
    "mháighistiríbh" => "mháistiribh",
    "sgiomar" => "sciomar",
    "sgrannradh" => "scanradh",
    "acfuinneach" => "acmhainneach",
    "adhbhar" => "ábhar",
    "áirighthe" => "áirithe",
    "airís" => "arís",
    "aoírde" => "aoirde",
    "árda" => "arda",
    "árdán" => "ardán",
    "árd" => "ard",
    "ars'an" => "arsan",
    "arsa'n" => "arsan",
    "bhféadan" => "bhféadann",
    "bhféadfaimís" => "bhféadfaimis",
    "bhfeirmeóir" => "bhfeirmeoir",
    "bhfuirm" => "bhfoirm",
    "bhiadh" => "bhia",
    "bhi" => "bhí",
    "bhímís" => "bhímis",
    "bhíon" => "bhíonn",
    "bhuidhchais" => "bhuíochais",
    "bhuidhe" => "bhuí",
    "bhulóg" => "bhollóg",
    "bhúntáiste" => "bhuntáiste",
    "biadh" => "bia",
    "buadh" => "bua",
    "buidhe" => "buí",
    "céadna" => "céanna",
    "ceathramhadh" => "ceathrú",
    "ceisteana" => "ceisteanna",
    "ceistiuchán" => "ceistiúchán",
    "ceólmhar" => "ceolmhar",
    "choídhche" => "choíche",
    "chómhairle" => "chomhairle",
    "chómharsa" => "chomharsa",
    "chómhartha" => "chomhartha",
    "chómh" => "chomh",
    "chosg" => "chosc",
    "cómhairle" => "comhairle",
    "cómharsa" => "comharsa",
    "cómharsan" => "comharsan",
    "cómhchruinn" => "comhchruinn",
    "creideamhnach" => "creidiúnach",
    "críochnuigheadh" => "críochnaíodh",
    "Críosdaidhe" => "Críostaí",
    "Críostaidhe" => "Críostaí",
    "croídhe" => "croí",
    "conus" => "conas",
    "coruighe" => "coraí",
    "cos-ar-bolg" => "cos ar bolg",
    "cosdais" => "costais",
    "cráidhte" => "cráite",
    "cu" => "cú",
    "cúigmhadh" => "cúigiú",
    "cúntas" => "cuntas",
    "d'aireófá" => "d'aireofá",
    "d'aoís" => "d'aois",
    "d'árdughadh" => "d'ardú",
    "d'árduigh" => "d'ardaigh",
    "deagh-chroídheach" => "dea-chroíoch",
    "d'éaluigh" => "d'éalaigh",
    "dh'aireóch'" => "d'aireodh",
    "dh'airighinn" => "d'airínn",
    "dh'aois" => "d'aois",
    "dh'ardughadh" => "d'ardú",
    "dh'árdughadh" => "d'ardú",
    "dhiaigh" => "dhiaidh",
    "Dhiarmuda" => "Dhiarmada",
    "dhícheal" => "dhícheall",
    "dhíchil" => "dhíchill",
    "dhísgiughadh" => "dhísciú",
    "dh'ithe" => "d'ithe",
    "dhlígh" => "dhlí",
    "dhlúithte" => "dhlúite",
    "dóibh-sin" => "dóibh sin",
    "dóich" => "dóigh",
    "dóighte" => "dóite",
    "eadh" => "ea",
    "éadtroma" => "éadroma",
    "eirighe" => "éirí",
    "eirigh" => "éirigh",
    "eirighthe" => "éirithe",
    "éirighthe" => "éirithe",
    "éirimeamhail" => "éirimiúil",
    "éirleach" => "eirleach",
    "feóil" => "feoil",
    "feóla" => "feola",
    "fhághail" => "fháil",
    "fheadar-sa" => "fheadarsa",
    "fhéadfaimíd" => "fhéadfaimid",
    "fhéadfá-sa" => "fhéadfása",
    "fheidir" => "fhéidir",
    "fheirmeóir" => "fheirmeoir",
    "fheóil" => "fheoil",
    "fheuchaint" => "fhéachaint",
    "fiafraighe" => "fiafraí",
    "fiain" => "fiáin",
    "foghanta" => "fónta",
    "fóghanta" => "fónta",
    "foghluim" => "foghlaim",
    "foghluma" => "foghlama",
    "foghlumtha" => "foghlamtha",
    "foláin" => "folláin",
    "fuathmhar" => "fuafar",
    "fuinneamhail" => "fuinniúil",
    "fuínseóige" => "fuinseoige",
    "gádh" => "gá",
    "gaedhlaibh" => "gaelaibh",
    "ghaedhlaibh" => "ghaelaibh",
    "'gha" => "á",
    "'ghá" => "á",
    "ghádh" => "ghá",
    "gháirdín" => "ghairdín",
    "gharaidhe" => "gharraí",
    "ghearadh" => "ghearradh",
    "h-abartha" => "habartha",
    "h-abhan" => "habhann",
    "imthigh" => "imigh",
    "imthighthe" => "imithe",
    "leó" => "leo",
    "león" => "leon",
    "leór" => "leor",
    "mhódh" => "mhodh",
    "mhothuigh" => "mhothaigh",
    "mhuinteardha" => "mhuinteartha",
    "mhuíntir" => "mhuintir",
    "mí-ádhbharach" => "mí-ámharach",
    "n-uradhas" => "n-urrús",
    "ó-dheas" => "ó dheas",
    "oidhche" => "oíche",
    "oídhche" => "oíche",
    "oificeach" => "oifigeach",
    "olan" => "olann",
    "ortha" => "orthu",
    "ortha-san" => "orthusan",
    "prísúnach" => "príosúnach",
    "puínn" => "puinn",
    "púnt" => "punt",
    "rádh" => "rá",
    "uaithe" => "uaithi",
    "uatha" => "uathu",
    "uathbhásach" => "uafásach",
    "ughdarás" => "údarás",
    "túisge" => "túisce",
    "tuisgint" => "tuiscint",
    "trímhadh" => "tríú",
    "truagh" => "trua",
    "tsaoghail" => "tsaoil",
    "tsaoghal" => "tsaol",
    "thruagh" => "thrua",
    "sisi" => "sise",
    "siubhal" => "siúl",
    "siúbhal" => "siúl",
    "ní'l" => "níl",
    "ndeire" => "ndeireadh",
    "ndiaigh" => "ndiaidh",
    "ndícheal" => "ndícheall",
    "muínteartha" => "muinteartha",
    "múinteóir" => "múinteoir",
    "muíntir" => "muintir",
    "módh" => "modh",
    "luighe" => "luí",
    "luighfeadh" => "luífeadh",
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
    s/\b[Dd]’ár bh’ ?/dárbh /gi;
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
    s/\bi n-Éirinn/in Éirinn/gi;
    s/\bana bheag/an-bheag/gi;
    s/\bana mhaith/an-mhaith/gi;
    s/\bana mhór/an-mhór/gi;
    s/\bn’ osguil/n'oscail/gi;
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
