from fabric.api import *

def build():
    with lcd('docs'):
        local('sphinx-build -b html -d _build/doctrees . _build/html')
