#!/bin/sh



_BASEPATH_=$(dirname `readlink -f $BASH_SOURCE`)
_DEPLOYPATH_=$_BASEPATH_/deploy
_BUILDPATH_=$_BASEPATH_/build



function _is_exclude() {

	echo $2 | grep -e "^\(.gitignore\|.project.build.exclude\|.project.path.\(lib\|bin\)\(.[0-9]\+\)\?\)$" > /dev/null 2>&1
	[ $? -eq 0 ] && return 0

	local IFS=$'\n'

	for _LINE_ in $(cat $1)
	do
		echo $_LINE ":"$2
		[ $_LINE_ = $2 ] && return 0
	done
}



cd $_BUILDPATH_
[ $? -ne 0 ] && exit $?

for _FILE_ in $(ls -A)
do
	_is_exclude $_BUILDPATH_/.project.build.exclude $_FILE_
	[ $? -eq 0 ] && continue

	rm -rfv $_FILE_
	[ $? -ne 0 ] && exit $?
done



cd $_DEPLOYPATH_
[ $? -ne 0 ] && exit $?

for _FILE_ in $(ls -A)
do
	_is_exclude $_DEPLOYPATH_/.project.build.exclude $_FILE_
	[ $? -eq 0 ] && continue

	cp -rv $(readlink -f $_FILE_) $_BUILDPATH_
	[ $? -ne 0 ] && exit $?
done



exit 0




