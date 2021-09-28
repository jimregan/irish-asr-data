#!/bin/bash
touch daltai.txt
sent=1
for u in seanfhocal-na-seachtaine living-and-dying material-things personal-qualities-types-of-people relationships-dealing-with-others the-bigger-world
do
	url="http://www.daltai.com/proverbs/$u/"
	lynx -dump $url|grep "$url"|awk '{print $2}'|grep -v '/#'|grep -v "^$url$"|sort|uniq | while read i
	do
		head=$(lynx -source $i/|grep '<h1>' |awk -F'[<>]' '{print $3}'|head -n 1)
		url=$(lynx -source $i/|grep '<audio'|awk -F'src="' '{print $2}'|awk -F'"' '{print "http://www.daltai.com"$1}'|head -n 1)
		grep $url daltai.txt || printf "%08d\t%s\t%s\t%s\n" $sent $i "$head" $url >> daltai.txt
		sent=$(($sent + 1))
	done
done
