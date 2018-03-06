#!/bin/sh



GEN=$(basename `readlink -f $BASH_SOURCE`)
SRC=$(dirname `readlink -f $BASH_SOURCE`)
DST=$(readlink -f "$1")

if [ ! -w $(dirname $DST) ]
then
	echo "error: invalid destnation"
	echo "usage: gen.sh <DEST_PATH>"
	exit 1
fi

RET=0

cp -rv $SRC $DST
RET=$(($RET | $?))

echo
rm -rfv `find $DST -name ".git"`
RET=$(($RET | $?))
echo
rm -rfv `find $DST -name ".gitignore"`
RET=$(($RET | $?))
echo
rm -rfv `find $DST -name "LICENSE"`
RET=$(($RET | $?))
rm -rfv `find $DST -name "README.md"`
RET=$(($RET | $?))
rm -rfv `find $DST -name $GEN`
RET=$(($RET | $?))

echo
echo "result: $RET"

exit $RET
