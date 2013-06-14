#!/bin/bash

# OSX bin-dist script
#
# It grabs the binary, data files and libs and bundles them all
# in cotton wool.

# Run ./scripts/build-osx.sh "./configure && make" and you should have a nice
# pioneer-osx.bz2 file in the root of the project directory.

PIONEER="/Users/Phil/dev/pioneer"
DIST="${PIONEER}/pioneer-osx"
DATE=`date +%Y-%m-01`
COUNTER="`git rev-list --since=${DATE} HEAD | wc -l | sed -e 's/^[ \t]*//'`"
BASEOUTFILE="pioneer-${DATE}.${COUNTER}-osx"
UPLOAD_DIR=philbywhizz,pioneerspacesim@frs.sf.net:/home/frs/project/p/pi/pioneerspacesim

cd $PIONEER

echo "Packaging..."

if [ -d $DIST ]; then
	rm -fr $DIST
fi

mkdir $DIST

# copy the pioneer binary
cp $PIONEER/src/pioneer $DIST/pioneer.osx

# copy the text files
cp $PIONEER/*.txt $DIST/

# copy the licenses folder
cp -r $PIONEER/licenses $DIST/licenses

# copy the data folder
cp -r $PIONEER/data $DIST/data

# Copy over libs
mkdir $DIST/libs
cp /opt/local/lib/libfreetype.6.dylib $DIST/libs
cp /opt/local/lib/libGLEW.1.9.0.dylib $DIST/libs
cp /opt/local/lib/libassimp.3.dylib $DIST/libs
cp /opt/local/lib/libsigc-2.0.0.dylib $DIST/libs
cp /opt/local/lib/libSDL-1.2.0.dylib $DIST/libs
cp /opt/local/lib/libSDL_image-1.2.0.dylib $DIST/libs
cp /opt/local/lib/libSDL_sound-1.0.1.0.2.dylib $DIST/libs
cp /opt/local/lib/libvorbisfile.3.dylib $DIST/libs
cp /opt/local/lib/libbz2.1.0.dylib $DIST/libs
cp /opt/local/lib/libjpeg.9.dylib $DIST/libs
cp /opt/local/lib/libogg.0.dylib $DIST/libs
cp /opt/local/lib/libpng15.15.dylib $DIST/libs
cp /opt/local/lib/libtiff.5.dylib $DIST/libs
cp /opt/local/lib/libvorbis.0.dylib $DIST/libs
cp /opt/local/lib/libX11.6.dylib $DIST/libs
cp /opt/local/lib/libXau.6.dylib $DIST/libs
cp /opt/local/lib/libxcb.1.dylib $DIST/libs
cp /opt/local/lib/libXdmcp.6.dylib $DIST/libs
cp /opt/local/lib/libXext.6.dylib $DIST/libs
cp /opt/local/lib/libXrandr.2.dylib $DIST/libs
cp /opt/local/lib/libXrender.1.dylib $DIST/libs
cp /opt/local/lib/libz.1.dylib $DIST/libs
cp /opt/local/lib/liblzma.5.dylib $DIST/libs

# Copy over the shell script
cp $PIONEER/osx/pioneer.sh $DIST/pioneer

# Now archive this all up
echo "Archiving..."
/usr/bin/tar cf $BASEOUTFILE.tar pioneer-osx
/usr/bin/bzip2 $BASEOUTFILE.tar

# Testing
read -n 1 -p "Pausing for testing $BASEOUTFILE <ENTER>"

# Uploading
echo "Uploading $BASEOUTFILE.tar.bz2"
scp $BASEOUTFILE.tar.bz2 $UPLOAD_DIR
# Clean up
rm -fr $DIST
rm $BASEOUTFILE.tar.bz2

# All done