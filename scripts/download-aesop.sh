#!/bin/sh

male="leon-agus-an-luch an-fearr-agus-a-bheirt-inionacha an-ghaoth-aagus-an-ghrian an-cailin-agus-cearca ghiorrai-agus-a-chairde luch-tuaithe-agus-an-luch-baile cat-agus-na-lucha"
female="coileach-agus-an-madra cat-agus-an-sionnach madra-sa-mhainsear"
for i in $male $female
do
	swf=$(lynx -source http://leighleat.com/$i.html|grep '<param name="movie"'|awk -F'"' '{print $4}')
	wget http://leighleat.com/$swf -O $i.swf
	perl extract-swf-mp3.pl $i.swf
	rm $i.swf
done

