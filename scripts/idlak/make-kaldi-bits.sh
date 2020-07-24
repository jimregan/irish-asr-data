echo "cll m" > spk2gender
grep 'fileid' text.xml|awk -F'"' '{print $2}'|while read id;do
	echo "$id cll" >> utt2spk
done
