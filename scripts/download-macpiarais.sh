#!/bin/sh

# Aonghus Ó Flatharta
aonghus="brid-na-namhran eoghainin-na-nean  an-gadai an-sagart na-boithre iosagain"
# Caoileann Ní Dhonnchadha
caoileann="an-bhean-chaointe an-mhathair bairbre deargadaol"
for i in $aonghus $caoileann
do
	swf=$(lynx -source http://leighleat.com/$i.html|grep '<param name="movie"'|awk -F'"' '{print $4}')
	wget http://leighleat.com/$swf -O $i.swf
	perl extract-swf-mp3.pl $i.swf
	rm $i.swf
done

