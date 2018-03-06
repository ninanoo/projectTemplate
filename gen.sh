#!/bin/sh
#set -x



GEN=$(basename `readlink -f $BASH_SOURCE`)
SRC=$(dirname `readlink -f $BASH_SOURCE`)
DST=$(readlink -f "$1")

if [ ! -w $(dirname $DST) ]
then
	echo "error: invalid destnation"
	echo "usage: gen.sh <DEST_PATH>"
	exit 1
fi

#cp -rv $SRC $DST
#
#[ $? -ne 0 ] && rm -rfv `find $DST -name ".git"`
#[ $? -ne 0 ] && rm -rfv `find $DST -name ".gitignore"`
#[ $? -ne 0 ] && rm -rfv `find $DST -name $GEN`
#
#exit $?

cp -rv $SRC $DST
RET=$?

echo
rm -rfv `find $DST -name ".git"`
echo
rm -rfv `find $DST -name ".gitignore"`
echo
rm -rfv `find $DST -name $GEN`

exit $RET
