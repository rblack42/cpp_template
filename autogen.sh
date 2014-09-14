#!/bin/sh

# check that libtool is installed
command -v libtool >/dev/null 1>&2
if [ $? -ne 0 ]; then
    echo "autogen.sh: error libtool not found, exiting" 1>&2
    exit 1
fi

# check that autoreconf is installed
command -v autoreconf >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "autogen.sh: error autoreconf not found, exiting" 1?&2
    exit 1
fi

# create config directory
mkdir -p ./config
if [ $? -ne 0 ]; then
    echo "autogen.sh: error - could not create config directory." 1>&2
    exit 1
fi

# run autoreconf
autoreconf --install --force --verbose -I config
if [ $? -ne 0 ]; then
    echo "autogen.sh error - autoreconf exited with status $?" 1>&2
    exit 1
fi
