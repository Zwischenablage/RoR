#!/bin/bash
DIR="$PWD/.."

find apps/ -type d -name original | xargs rm -rf
files=`find . -type f -name AndroidManifest.xml`

for f in $files
do
	newFilename=`echo $f | xargs dirname | xargs basename`
	echo "Moving $f towards $newFilename"
	cp $f $newFilename.xml
done
