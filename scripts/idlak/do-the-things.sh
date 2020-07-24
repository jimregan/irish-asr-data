echo Preparing to do the things
perl -MXML::LibXML -e 1
if [ $? -ne 0 ];then
	echo Need the Perl module XML::LibXL
	echo   sudo apt-get install libxml-libxml-perl
	echo Or:
	echo   cpan XML::LibXML
	exit 1
fi
echo Downloading the things
wget https://raw.githubusercontent.com/Idlak/Living-Audio-Dataset/master/ga/ie/cll/text.xml
wget https://raw.githubusercontent.com/Idlak/idlak/master/idlak-data/ga/ie/lexicon-default.xml
wget https://archive.org/download/ga.ie.cll.48000.tar/ga.ie.cll.48000.tar.gz

echo Making some kaldi things
echo "cll m" > spk2gender
grep 'fileid' text.xml|awk -F'"' '{print $2}'|while read id;do
	echo "$id cll" >> utt2spk
done

echo Converting the things
perl convert-idlak-text.pl
perl convert-idlak-lexicon.pl | perl adjust-phones.pl -a > lexicon.txt

