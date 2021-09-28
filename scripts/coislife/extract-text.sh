#!/bin/bash
# Run after guess-and-copy-pdfs.pl pointed at the same path
# Runs a pdftotext wrapper on those pdfs to get cleaner text

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

set -e

function usage() {
  echo "Usage: extract-text.sh [path to files]"
  exit 1
}

function ex() {
  if [ "$#" -lt 3 ]
  then
    echo "ex: at least three arguments required"
    exit 1
  fi
  opt=""
  if [ "$#" -gt 3 ]
  then
    opt="--pagenums $4"
  fi
  if [ "$#" -gt 4 ]
  then
    opt="$opt --appendpunct $5"
  fi
  perl "$SCRIPTPATH/pdfextract.pl" --first $2 --last $3 $opt "$1"
}

function exseadna() {
  opt="--appendpunct $2"
  if [ "$#" -gt 5 ]
  then
    opt=""
  fi
  perl "$SCRIPTPATH/pdfextract.pl" --first $2 --last $3 --pagenums last $opt --leftx 20 --rightx 375 --y 20 --width 450 --height 550 --firstside $4 --lastside $5 "$1"
}

function procfile() {
  file=$1
  case $file in
    "ibiotsa_c1.pdf") ex "$file" 4 11 last 4 > ibiotsa_c1.txt ;;
    "an_tiriseoir_c1.pdf") ex "$file" 5 22 last 5 > an_tiriseoir_c1.txt ;;
    "i_dtir_mhilis_na_mbeo_c1.pdf") ex "$file" 7 17 last 7 |grep -v '^◆$' > i_dtir_mhilis_na_mbeo_c1.txt ;;

    "an_tiriseoir.pdf")
      ex "$file" 5 22 last 5 | grep -v '^6$' > an-tiriseoir-01.txt
      ex "$file" 23 42 last 23 > an-tiriseoir-02.txt
      ex "$file" 43 67 last 43 > an-tiriseoir-03.txt
      ex "$file" 68 88 last 68 > an-tiriseoir-04.txt
      ex "$file" 89 111 last 89 > an-tiriseoir-05.txt
      ex "$file" 112 132 last 112 > an-tiriseoir-06.txt
      ex "$file" 133 156 last 133 > an-tiriseoir-07.txt
    ;;
    "aois_fir.pdf")
      ex "$file" 5 30 last 5,15,19,25 > aois-fir-01.txt
      ex "$file" 31 56 last 31,37,43,49,53 > aois-fir-02.txt
      ex "$file" 57 80 last 57,63,67,71,75 > aois-fir-03.txt
      ex "$file" 81 104 last 81,87,97,101 > aois-fir-04.txt
    ;;
    "daideo.pdf")
      ex "$file" 3 75 last 3,8,12,16,20,24,29,35,42,45,50,55,58,62,66,70,72 > daideo.txt
    ;;
    "hata_zu_mhamo.pdf")
      ex "$file" 5 25 last 5,10,16,21 > hata-zu-mhamo-01.txt
      ex "$file" 26 51 last 26,31,36,40,45,48 > hata-zu-mhamo-02.txt
      ex "$file" 52 66 last 52,57,60,63,65 > hata-zu-mhamo-03.txt
    ;;
    "i_dtir_mhilis_na_mbeo.pdf")
      ex "$file" 7 23 last 7 | grep -v '◆' > i-dtir-mhilis-na-mbeo-01.txt
      ex "$file" 25 48 last 25 | grep -v '◆' > i-dtir-mhilis-na-mbeo-02.txt
      ex "$file" 51 64 last 51 | grep -v '◆' > i-dtir-mhilis-na-mbeo-03.txt
      #ex "$file" 67 80 last 67 | grep -v '◆' > i-dtir-mhilis-na-mbeo-04.txt
      ex "$file" 83 114 last 83 | grep -v '◆' > i-dtir-mhilis-na-mbeo-04.txt
      #ex "$file" 117 132 last 117 | grep -v '◆' > i-dtir-mhilis-na-mbeo-05.txt
      #ex "$file" 135 155 last 135 | grep -v '◆' > i-dtir-mhilis-na-mbeo-06.txt
      #ex "$file" 158 165 last 158 | grep -v '◆' > i-dtir-mhilis-na-mbeo-07.txt
      ex "$file" 168 169 last 168 |sed -e 's/^i$/a haon/;s/^ii$/dó/;s/^iii$/trí/'| grep -v '◆' > i-dtir-mhilis-na-mbeo-05.txt
      ex "$file" 171 181 last 158 | grep -v '◆' > i-dtir-mhilis-na-mbeo-06.txt
    ;;
    "ibiotsa.pdf")
      ex "$file" 5 18 last 5 > ibiotsa-01.txt
      ex "$file" 21 35 last 21 > ibiotsa-02.txt
      ex "$file" 37 49 last 37 > ibiotsa-03.txt
      ex "$file" 51 65 last 51 > ibiotsa-04.txt
      ex "$file" 67 79 last 67 > ibiotsa-05.txt
      ex "$file" 81 94 last 81 |grep -v '\*\*\*\*\*\*\*' > ibiotsa-06.txt
      ex "$file" 97 109 last 97 > ibiotsa-07.txt
      ex "$file" 111 120 last 111 > ibiotsa-08.txt
      ex "$file" 123 134 last 123 |grep -v '\*\*\*\*\*\*\*\*\*' > ibiotsa-09.txt
    ;;
    "oilithreach_pinn.pdf")
      ex "$file" 7 25 last 7,11,18 | sed -e 's/^[123]\. //'|perl -CS -Mutf8 -pe 's/^([123]?[0-9] (?:Meán|Deireadh) Fómhair)$/$1./' > oilithreach-pinn-01.txt
      ex "$file" 26 37 last 26 | sed -e 's/^[4]\. //'|perl -CS -Mutf8 -pe 's/^([123]?[0-9] (?:Meán|Deireadh) Fómhair)$/$1./' > oilithreach-pinn-02.txt
      ex "$file" 38 37 last 38 | sed -e 's/^[4]\. //'|perl -CS -Mutf8 -pe 's/^([123]?[0-9] (?:Meán|Deireadh) Fómhair)$/$1./' > oilithreach-pinn-03.txt
    ;;
    "seadna.pdf")
      exseadna "$file" 38 40 r r > seadna-01.txt
      exseadna "$file" 41 43 l r > seadna-02.txt
      exseadna "$file" 44 47 l r > seadna-03.txt
      exseadna "$file" 48 51 l r > seadna-04.txt
      exseadna "$file" 52 55 l r > seadna-05.txt
      exseadna "$file" 56 59 l r > seadna-06.txt
      exseadna "$file" 60 63 l r > seadna-07.txt
      exseadna "$file" 64 68 l l > seadna-08.txt
      exseadna "$file" 68 73 r r > seadna-09.txt
      exseadna "$file" 74 76 l l > seadna-10.txt
      exseadna "$file" 76 77 r l > seadna-11.txt
      exseadna "$file" 78 81 l l - >> seadna-11.txt
      exseadna "$file" 81 84 r r > seadna-12.txt
      exseadna "$file" 85 88 l l > seadna-13.txt
      exseadna "$file" 88 93 r r > seadna-14.txt
      exseadna "$file" 94 96 l r > seadna-15.txt
      exseadna "$file" 97 99 l r > seadna-16.txt
      exseadna "$file" 100 104 l l > seadna-17.txt
      exseadna "$file" 104 108 r r > seadna-18.txt
      exseadna "$file" 109 112 l r > seadna-19.txt
      exseadna "$file" 113 117 l l > seadna-20.txt
      exseadna "$file" 117 120 r l > seadna-21.txt
      exseadna "$file" 120 122 r r > seadna-22.txt
      exseadna "$file" 123 126 l r > seadna-23.txt
      exseadna "$file" 127 129 l r > seadna-24.txt
      exseadna "$file" 130 133 l r > seadna-25.txt
      exseadna "$file" 134 138 l l > seadna-26.txt
      exseadna "$file" 138 140 r r > seadna-27.txt
      exseadna "$file" 141 142 l r > seadna-28.txt
      exseadna "$file" 143 147 l l > seadna-29.txt
      exseadna "$file" 147 149 r r > seadna-30.txt
      exseadna "$file" 150 155 l l > seadna-31.txt
      exseadna "$file" 155 161 r l > seadna-32.txt
      exseadna "$file" 161 164 r r > seadna-33.txt
      exseadna "$file" 165 166 l r > seadna-34.txt
    ;;
    *) ;;
  esac
}

if [ x$1 = x"" ]
then
  usage
fi

path=$1
if [ ! -d "$path" ]
then
  echo "$path: not a directory"
  usage
fi

pushd $1

for file in *pdf
do
  procfile "$file"
done

popd
