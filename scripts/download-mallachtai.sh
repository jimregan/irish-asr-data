#!/bin/sh
# Reader: Móirín Nic Concra

for i in 1 2 3 4 5 6 7
do
	swf=$(lynx -source http://leighleat.com/caibidil-$i.html|grep '<param name="movie"'|awk -F'"' '{print $4}')
	wget http://leighleat.com/$swf -O mallachtai$i.swf
	perl extract-swf-mp3.pl mallachtai$i.swf
	rm mallachtai$i.swf
done

