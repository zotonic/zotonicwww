#!/bin/bash

set -v

# passed in from mod_zotonicdocs
ZOTONIC="$1"
TARGET="$2"

# which branches to build documentation for
DOCBRANCHES="release-0.9.x release-0.10.x master"

cd $ZOTONIC

for branch in $DOCBRANCHES; do
    pretty=`echo $branch|sed 's/master/latest/'|sed 's/release-//'|sed 's/\.x//'`
    git clean -f -x
    git co $branch;
    git merge origin/$branch
    cd doc
    builddir="_build/$pretty"
    mkdir -p $builddir
    BUILDDIR=$builddir make -e clean stubs production-html
    #BUILDDIR=$builddir make -e production-html
    cd ..
done

rsync -uva --delete $ZOTONIC/doc/_build/ $TARGET

