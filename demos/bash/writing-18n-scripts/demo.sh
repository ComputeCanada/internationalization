#!/bin/bash

#
# i18n_msgid is used as a keyword for xgettext to extract strings from this
# script in to a .pot file. All other strings are ignored.
#

i18n_msgid()
{
  # TEXTDOMAIN and TEXTDOMAINDIR are best set immediately before calling
  # gettext (which ensures things work especially when using a custom
  # domain and directory name)...
  TEXTDOMAIN=demo TEXTDOMAINDIR=./locale gettext -s "$1"
}

echo $(i18n_msgid 'hello')
