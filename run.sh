#!/bin/sh
BASE="$(cd "$(dirname "$0")" && pwd)"
HUGO=$BASE/bin/hugo

chmod +x $HUGO

cd $BASE

ARGS="  -D \
		--config config.yaml"

build() {
	git config --global pull.rebase true
	git submodule foreach git pull
	$HUGO $ARGS -d ../docs
}

publish() {
	git branch --set-upstream-to=origin/main main
	cd ../docs && git pull && git push
	cd -
}

server() {
	$HUGO server $ARGS -p 3000 --bind 0.0.0.0 --baseURL localhost --disableFastRender
}

commit() {
	git add .
	git commit -m "commit $(date +%Y-%m-%d\ %H:%M:%S)"
	git push origin main
}


while getopts ':bscph' P; do 
	case $P in
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
