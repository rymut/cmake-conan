import sys
import os

import requests

colors_url = "https://raw.githubusercontent.com/Kitware/CMake/master/Utilities/Sphinx/colors.py"
response = requests.get(colors_url)
file = open("_ext/colors.py", "wb")
file.write(response.content)
file.close()
cmake_url = "https://raw.githubusercontent.com/Kitware/CMake/master/Utilities/Sphinx/cmake.py"
response = requests.get(cmake_url)
file = open("_ext/cmake.py", "wb")
file.write(response.content)
file.close()

# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'conan-cmake'
copyright = '2023, test'
author = ''
release = ''

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
language = 'en'
primary_domain = 'cmake'
highlight_language = 'none'


sys.path.append(os.path.abspath("./_ext"))
extensions = ['cmake']

source_suffix = {
    '.rst': 'restructuredtext',
    '.md': 'markdown'
}

templates_path = ['_templates']
exclude_patterns = [ ]



# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'alabaster'
html_static_path = ['_static']
