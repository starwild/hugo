#!/bin/sh
BASE="$(cd "$(dirname "$0")" && pwd)"
HUGO=$BASE/bin/hugo
DOCS=../docs

chmod +x $HUGO

cd $BASE

ARGS="-D --config config.yaml"

read1() {
	rm -rf $DOCS
	git clone https://github.com/starwild/starwild.github.io $DOCS
}

build() {
	git submodule update --init --recursive
	$HUGO $ARGS -d $DOCS
}

publish() {
	git branch --set-upstream-to=origin/main main
	pushd $DOCS 
	git push
	popd
}

server() {
	$HUGO server $ARGS -p 3000 --bind 0.0.0.0 --baseURL localhost --disableFastRender
}

commit() {
	git add .
	git commit -m "commit $(date +%Y-%m-%d\ %H:%M:%S)"
	git push origin main
}


while getopts ':rbscph' P; do 
	case $P in
		r)
			read1
		;;
		b)
			build
		;;
		s)
			server
		;;
		c)
			commit
		;;
		p)
			publish
		;;
		h)
			echo "usage: `basename $0` [options]"
		;;
	esac
done

shift $(($OPTIND - 1))
