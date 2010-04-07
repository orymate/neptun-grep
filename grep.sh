#!/bin/bash

BASE=/home/web/.irssi/scripts
RES=`mktemp`
if ! grep -i --color=always -E -e "$1" $BASE/i3.csv > $RES
then
	if ! grep -i --color=always -E -e "$1" $BASE/i3.ascii.csv > $RES
	then
		echo nincs talalat > $RES
	fi
fi

(
cat $RES | tr ':' ' ' | head -8 | sed -e 's/$/ || /g' | tr -d '\n' | sed -e 's/|| $//' | sed -e 's/\x1B\[01;31m\x1B\[K//g' -e 's/\x1B\[m\x1B\[K//g'
if [ `wc -l < $RES` -gt 8 ]
then
	echo ...
else
	echo
fi
) 2>/dev/null | head -1
rm -f $RES
