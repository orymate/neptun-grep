#!/bin/bash
if [ $# -lt 3 ]
then
    echo Usage: $0 pattern file1 file2 >&2
    exit 1
fi
   
RES=`mktemp`

# grep for positional parameter #1 in $2
if ! grep -i --color=always -E -e "$1" $2 > $RES
then
    # try in dumb version ($3)
	if ! grep -i --color=always -E -e "$1" $3 > $RES
	then
		echo nincs talalat > $RES
	fi
fi

(
# get rid of column separator, limit results, make them inline, 
# remove tail separator, make coloring irssi compatible
cat $RES | tr ':' ' ' | head -8 | sed -e 's/$/ || /g' | tr -d '\n' \
    | sed -e 's/|| $//' \
    | sed -e 's/\x1B\[01;31m\x1B\[K//g' -e 's/\x1B\[m\x1B\[K//g'

if [ `wc -l < $RES` -gt 8 ]
then
	echo ...
else
	echo
fi

) 2>/dev/null | head -1
rm -f $RES
