cat ../pron/ulster.tsv ../pron/connacht.tsv ../pron/munster.tsv | sed -e 's/ˈ//g;s/ˌ//g;s/\([0-9]+\)//'|perl -C7 -ane 'my($a,$b)=split/\t/;next if($a=~/ /);$a=~s/([nt])([AEIOUÁÉÍÓÚ])/$1-$2/g;$a=lc($a);$b=~s/^ //;$b=~s/ $//;$b=~s/  +/ /g;print "$a\t$b";'| sort|uniq |perl convlex.pl > teanglann.dic
