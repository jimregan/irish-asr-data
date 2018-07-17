#!/bin/bash
# 

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
  perl $SCRIPTPATH/pdfextract.pl --first $2 --last $3 $opt "$1"
}

function procfile() {
  file=$1
  case $file in
    "ibiotsa_c1.pdf") ex "$file" 4 11 last 4 > ibiotsa_c1.txt ;;
    "an_tiriseoir_c1.pdf") ex "$file" 5 22 last 5 > an_tiriseoir_c1.txt ;;
    "i_dtir_mhilis_na_mbeo_c1.pdf") ex "$file" 7 17 last 7 |grep -v '^◆$' > i_dtir_mhilis_na_mbeo_c1.txt ;;
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
