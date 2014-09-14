#ifndef __PYLIT_H__
#define __PYLIT_H__

//  Version macros for compile-time API version detection                     */
#define PYLIT_VERSION_MAJOR 0
#define PYLIT_VERSION_MINOR 1
#define PYLIT_VERSION_PATCH 0

#define PYLIT_MAKE_VERSION(major, minor, patch) \
    ((major) * 10000 + (minor) * 100 + (patch))
#define PYLIT_VERSION \
    PYLIT_MAKE_VERSION(PYLIT_VERSION_MAJOR, PYLIT_VERSION_MINOR, PYLIT_VERSION_PATCH)

#dendif
