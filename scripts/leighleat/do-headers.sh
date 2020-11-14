for i in $(seq 1 12)
do
    url=http://www.leighleat.com/caib-$i.html
    echo "# Location: $url" >> caib-$i.head
    lynx -source $url|grep '<title>'|awk -F'<title>' '{print $2}'|awk -F'</title>' '{print "# HTML-Title: " $1}' >> caib-$i.head
    curl -v -s http://www.leighleat.com/caib-$i.html 2>&1 |grep Last-Mod|sed -e 's/^</#/' >> caib-$i.head
done
