#!/bin/sh

_BASEPATH_=$(dirname `readlink -f $BASH_SOURCE`)
_DEPLOYPATH_=$_BASEPATH_/deploy
_BUILDPATH_=$_BASEPATH_/build
_BUILDWEBPATH_=$_BASEPATH_/buildweb



[ ! -d $_BUILDPATH_/log -o ! -x $_BUILDPATH_/log ] && mkdir -v $_BUILDPATH_/log



rm -rfv $_BUILDPATH_/src

cd $_DEPLOYPATH_

ls -A > /dev/null 2>&1

if [ $? -eq 0 ]
then
	for _FILE_ in $(ls -A)
	do
		[ "$_FILE_" = ".gitignore" ] && continue

		cp -rv $(readlink -f $_FILE_) $_BUILDPATH_
	done
fi



#rm -rfv $_BUILDWEBPATH_/*
#
#ls $_BUILDPATH_/src/*.html > /dev/null 2>&1
#[ $? -eq 0 ] && cp -v *.html $_BUILDWEBPATH_/
#
#if [ $? -eq 0 ]
#then
#	for _FILE_ in $(ls $_BUILDPATH_/src/*.html)
#	do
#		cp -rv $(readlink -f $_FILE_) $_BUILDWEBPATH_/
#	done
#fi



exit 0




