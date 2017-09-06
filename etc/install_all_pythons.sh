#!/bin/sh

#set -x



_PATH_TAIL_=""
_FILE_LIST_=""

for _FILE_
do
	case $_FILE_ in
		--tail=*) _PATH_TAIL_=`echo "$_FILE_" | sed 's/^--tail=//'`
				  ;;
		*) if [ ! `echo "$_FILE_" | grep "..*\.tar\...*"` ]
		   then
			   echo "error: invalid tar archive $_FILE_"
			   exit 1
		   fi
		   _FILE_LIST_=$_FILE_LIST_${_FILE_LIST_:+ }$_FILE_
		   ;;
	esac
done

if [ ! "$_FILE_LIST_" ]
then
	_FILE_LIST_=`ls Python*.tar.*`
fi



_BASE_PATH_=$(dirname `readlink -f $BASH_SOURCE`)

cd $_BASE_PATH_			; [ $? -ne 0 ] && exit $?

_BASE_PATH_=$(dirname $_BASE_PATH_)

for _FILE_ in $_FILE_LIST_
do
	_SRC_PATH_=`echo "$_FILE_" | sed 's/\.tar\..*$//'`
	_DST_PATH_=$_SRC_PATH_$_PATH_TAIL_

	cd $_BASE_PATH_		; [ $? -ne 0 ] && exit $?
	rm -rf $_DST_PATH_	; [ $? -ne 0 ] && exit $?
	cd -				; [ $? -ne 0 ] && exit $?
	rm -rf $_SRC_PATH_	; [ $? -ne 0 ] && exit $?

	tar axvf $_FILE_	; [ $? -ne 0 ] && exit $?

	cd $_SRC_PATH_		; [ $? -ne 0 ] && exit $?

	./configure --prefix="$_BASE_PATH_/$_DST_PATH_" --enable-shared	; [ $? -ne 0 ] && exit $?

	make				; [ $? -ne 0 ] && exit $?
	make altinstall		; [ $? -ne 0 ] && exit $?

	cd -				; [ $? -ne 0 ] && exit $?
done



exit 0




