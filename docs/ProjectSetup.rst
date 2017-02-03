Setting Up a C++ Project
########################

This repository holds a project structure that can be used for C++ lab projects
in my classes.

Yhe Makefile included in the root of this directory structure will build the
required subdirectories if you run "make init" as a first step. Following that
you populate the "src" folder with your application's **main.cpp** file, and place
all class implementation files under "lib". Any unit test files should be
stored under "tests. This setup uses the Catch project, which is just a single
header file. ALl header files for the project are stored under "includes"

Make Targets
************

    * **make init** - directory setup

    * **make debug** - lists of source, object and dependency files

    * **make** - builds application and test program (nmes are specified in the Makefile)

    * **make clean** - removes all constructed files.

..  vim:ft=rst spell:
