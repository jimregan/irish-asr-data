mkdir wav
find $1 -name '*.mp3' |perl -ane 'BEGIN{my $c = 0}{$c++;chomp;print $_ . "\t" . sprintf("%07d", $c) . "\n";}'|while read i;do ffmpeg -i "$(echo "$i"|awk -F'\t' '{print $1}')" -acodec pcm_s16le -ac 1 -ar 16000 wav/$(echo "$i"|awk -F'\t' '{print $2}').wav;done
