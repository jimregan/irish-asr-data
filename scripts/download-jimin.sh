#!/bin/sh
# Reader: Dara Ó Cinnéide

# Chapters 5 & 6 are missing
for i in 1 2 3 4 7 8 9 10 11 12
do
	swf=$(lynx -source http://leighleat.com/caib-$i.html|grep '<param name="movie"'|awk -F'"' '{print $4}')
	wget http://leighleat.com/$swf -O jimin$i.swf
	perl extract-swf-mp3.pl jimin$i.swf
	rm jimin$i.swf
done
	
