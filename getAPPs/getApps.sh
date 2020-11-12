#!/bin/bash
DIR="apps"
ORIG="original_apks"
rm -rf $DIR
mkdir $DIR

pushd $DIR

SYSTEM=`adb shell find /system -name *.apk`
VENDOR=`adb shell find /vendor -name *.apk`
PRODUCT=`adb shell find /product -name *.apk`

for f in $SYSTEM
do
	adb pull $f
done


for f in $VENDOR
do
	adb pull $f
done


for f in $PRODUCT
do
	adb pull $f
done

FILES=`ls`
echo "FILES: $PWD --> $FILES"

for f in $FILES
do
	apktool d $f
done

mkdir $ORIG
mv *.apk $ORIG


popd
