#!/bin/sh

get_pdf_name() {
	base=$(basename $1 '.mp4')
	case $base in
		20101123mean|20111109mean|20140311mean|20120320mean)
			echo "$(basename $base 'mean')bun.pdf"
			;;
		*)
			echo "$base.pdf"
			;;
	esac
}

num_pages() {
    pdfinfo $1|grep '^Pages:'|awk '{print $2}'
}
