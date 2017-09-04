#!/bin/sh



_BASE_PATH_=$(dirname `readlink -f $BASH_SOURCE`)

cd $_BASE_PATH_			; [ $? -ne 0 ] && exit $?

_BASE_PATH_=$(dirname $_BASE_PATH_)

IFS=$'\n'

for _FILE_ in $(ls -1 | grep -i -e "^Python.*\.tar\.xz$")
do
	_PATH_=$(expr "$_FILE_" : '\(.*\).......')

	cd $_BASE_PATH_		; [ $? -ne 0 ] && exit $?
	rm -rf $_PATH_		; [ $? -ne 0 ] && exit $?
	cd -				; [ $? -ne 0 ] && exit $?
	rm -rf $_PATH_		; [ $? -ne 0 ] && exit $?

	tar Jxvf $_FILE_	; [ $? -ne 0 ] && exit $?

	cd $_PATH_			; [ $? -ne 0 ] && exit $?

	./configure --prefix="$_BASE_PATH_/$(echo $_PATH_ | tr '[A-Z]' '[a-z]')" --enable-shared	; [ $? -ne 0 ] && exit $?

	make				; [ $? -ne 0 ] && exit $?
	make altinstall		; [ $? -ne 0 ] && exit $?

	cd -				; [ $? -ne 0 ] && exit $?
done



exit 0




