Documenting a C++ Project on GitHub
###################################

..  include::   /references.inc

After reading a blog post by `Travis Gockel
<http://blog.gockelhut.com/2014/09/automatic-documentation-publishing-with.html>`_
I decided to revisit setting up web pages for my projects on GitHub.
Originally, I thought about publishing the Sphinx documentation I usually
generate as part of a project. This time, I am going to let Doxygen_ generate
documentation for my project, and do the hard writing using my normal
publishing scheme. The Doxygen_ material is useful, but not as useful as other
material I want to produce. (Doxygen_ generates nice web pages that show you
`what` a program is made of, my notes tell you `why` it is composed that way!)

Example Project
***************

As a test case, I set up a simple C++ application and got the project up on my
GitHub_ account. You can find it at `this link
<https://github.com/rblack42/cpp_template.git>`_.


Generate an SSH Key for Travis CI
*********************************

To ensure security in our communications between our development system and
GitHub_, we should be using an SSH key pair. We should also secure
communications between GitHub_ and TravisCI_. We will generate a key pair for
this purpose here:

First, create the key pair on your local machine:

..  code-block:: text

    $ ssh-keygen -t rsa -C "rblack@austincc.edu" -f config/travisci_rsa

..  note::

    We do not want a passphrase here, since this key will be used by the
    automated systems at TravisCI_. There will be no human in that loop!

Once this step is complete, you will have two keys in the `config` directory: 

    * travisci_rsa - the private key

    * travisci_rsa.pub - the public key

Upload Public Key to GitHub
===========================

The `Public Key` file needs to be uploaded to GitHub_. Since this is the
`public` one, there is no need to worry about it being compromised. We will just add
this key to a project, and commit the file so it ends up on GitHUb_.

Upload the Private Key to Travis CI
===================================

Getting the private key to TravisCI_ is a bit of a problem. We do not want to
just upload it to our public repository. Unscrupulous snoopers might take the
file and attempt to break it. (Why, you might ask? Well, it is a good idea to
think about this, even if you doubt that there is a real issue here!)

TravisCI_ has way to encrypt the file so we can upload it to GitHub_. They will
find the key when they check out our project to run the tests.  (Layers of
security inside other layers. Neat!) 

Download the Travis CI CLI, a Ruby application:
===============================================

We can use tools provided by TravisCI_, if we install a command line interface
to their system. This is a simple Ruby application:

..  code-block:: text

    $ sdo gem install travis

    $ travis login

You will be asked for your GitHub_ login credentials. Next, we will encrypt the
private key file:

..  code-block:: text

    $ travis encrypt-file config/travisci_rsa --add

The system will make sure the directory you specify is a repository under
GitHub_ control by checking the .git directory files. Once it is sure things
are correct, the encrypted file will be created in `config/travisci_rsa.enc`.

We will commit this file, making sure to move the real private key out of the
repository (into your ~/.ssh directory).

..  code-block:: text

    $ mv config/travisci_rsa ~/.ssh
    $ mv travisci_rsa.enc config

This puts the encrypted file in the `config` directory, out of the way. We need
to edit the `.`travis.yml` so the new location works. (This file was modified
by the encryption operation.). We also add a few commands to put the key where
it needs to be when TravisCI_ sets things up for the tests.

..  code-block:: text

    ...
    before_install:
      - openssl aes-256-cbc 
        -K $encrypted_3075821fba54_key 
        -iv $encrypted_3075821fba54_iv
        -in config/travisci_rsa.enc 
        -out config/travisci_rsa -d
      - chmod 0600 config/travisci_rsa
      - cp config/travisci_rsa ~/.ssh/id_rsa

Your new setup is now more secure!

Setting up for Doxygen
**********************

Doxygen_ is a   powerful tool for creating standard documentation for your
project code. It supports a number of languages and can generate HTML pages
that users can use to browse the project code. All of the work to generate
these documents is automatic once you do a bit of setup work.

Doxygen Setup
=============

We start off my generating a configuration file for the project. This is a
template we will need to modify.

..  code-block:: text

    $ doxygen -g config/Doxyfile

Change settings as needed. I made these changes:

..  code-block:: text

    PROJECT_NAME = "C++ Template"

    PROJECT_NUMBER = "0.1.0"

    OUTPUT_DIRECTORY = build/doc

    INPUT = src

    EXTRACT_ALL = YES

That last option helps get started using Doxygen_.

The Doxygen_ manual details how you should document your code. Basically, you
add structured comments to your code so the tool can extract then as part of
the documentation process.

Here is what the example file looks like with comments added:

..  literalinclude::    ../src/factorial_doxy.cpp
    :language: c
    :linenos:




