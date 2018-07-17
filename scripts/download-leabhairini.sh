#!/bin/sh

for i in shuighh sa-teach mici thainig an-tra sa-chistin chuala sa-scoil sa-seomra-leaba
do
	swf=$(lynx -source http://leighleat.com/$i.html|grep '<param name="movie"'|awk -F'"' '{print $4}')
	wget http://leighleat.com/$swf -O $i.swf
	perl extract-swf-mp3.pl $i.swf
	swfstrings $i.swf | grep -v '^Críoch$' > $i.txt
	rm $i.swf
done

