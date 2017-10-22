C++ Template
############

This repository holds a project template students can use for for C++ projects
in my classes at Austin Community College. The template will build any project
needed and test the final result on Travis-CI. It uses ``catch.hpp`` as a
testing framework, and builds using ``make``. 

..  note::

    I use ``GitHub Classroom`` for thes classes, so this setup assumes you are
    using Git_ to manage things. You can use the template for other purposes,
    but that is up to you!

To see te available ``make`` targets, type "make help" at the prompt.

Creating a New Project
**********************

To start a new project from this template, one this project onto your
workstation.

..code-block::  bash

    $ git clone git@github.com/rblack42/cpp_template.git


Then do this:

..  code-block:: bash

    $ make new-project
    path: path_to_your_project_repo

This will copy all needed files into your working repository directory.

THen check things out by doing this:

..  code-block:: bash

    $ cd your-project-path
    $ make test

If this succeeds, commit the changes and push the project to GitHub_ as you
normally do for these projects.

If you are successful, and if I have activated your project for testing on
Travis-CI, your README file should show the "build/passing" badge. Green is
good!

