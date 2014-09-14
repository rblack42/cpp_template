#!/bin/sh
#
# This script extracts the PyLit version from include/pylit.h.
#
if [ ! -f include/pylit.h ]; then
    echo "version.sh: error: include/pylit.h does not exist" 1>&2
    exit 1
fi
MAJOR=`egrep '^#define +PYLIT_VERSION_MAJOR +[0-9]+$' include/pylit.h`
MINOR=`egrep '^#define +PYLIT_VERSION_MINOR +[0-9]+$' include/pylit.h`
PATCH=`egrep '^#define +PYLIT_VERSION_PATCH +[0-9]+$' include/pylit.h`
if [ -z "$MAJOR" -o -z "$MINOR" -o -z "$PATCH" ]; then
    echo "version.sh: error: could not extract version from include/pylit.h" 1>&2
    exit 1
fi
MAJOR=`echo $MAJOR | awk '{ print $3 }'`
MINOR=`echo $MINOR | awk '{ print $3 }'`
PATCH=`echo $PATCH | awk '{ print $3 }'`
echo $MAJOR.$MINOR.$PATCH | tr -d '\n'

