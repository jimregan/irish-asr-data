

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

get_pdf_name 20120320mean.mp4
