# -*- coding: utf-8 -*-
import os
import sys
sys.path.insert(0, os.path.abspath('.'))

YourName = u'YourName'

# -- General configuration ------------------------------------------------

extensions = []
templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'

# General information about the project.
project = u'CPUsim'
copyright = u'2017, ' + YourName
author = YourName

version = u'0.1'
release = u'0.1'

language = None
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store', '_venv']
pygments_style = 'sphinx'
todo_include_todos = False


# -- Options for HTML output ----------------------------------------------
html_theme = 'alabaster'
html_static_path = ['_static']
html_sidebars = {
    '**': [
        'about.html',
        'navigation.html',
        'relations.html',  # needs 'show_related': True theme option to display
        'searchbox.html',
        'donate.html',
    ]
}

# -- Options for LaTeX output ---------------------------------------------

latex_elements = {
    'papersize': 'letterpaper',
    'pointsize': '11pt',
    'figure_align': 'htbp',
}

latex_documents = [
    (master_doc, 'CPUsim.tex', u'CPUsim',
     YourName, 'manual'),
]



