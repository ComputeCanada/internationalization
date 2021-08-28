# Shell Internationalization Demonstration

**Author:** Paul Preney <preney@sharcnet.ca>

**Date:** August 25, 2021

## Instructions

To use this demonstration of BASH shell script internationalization:

 1. Ensure an "en" (English) and a "fr" (French) locale are installed on your system. Such can be seen by running `locale -a`. Said differnetly, this command needs to output at least 2:

        locale -a \
          | tee >(grep '^en' | wc -l) >(grep '^fr' | wc -l) >/dev/null \
          | xargs echo \
          | ( read a b ; echo $((a+b)) )

 2. Ensure the GNU gettext package is installed (it very likely already is).
 3. Run `make`. Its output should resemble the content of `SAMPLE-RUN.txt`. Running `make clean` will delete the files created from running `make`.

### NOTE:

 * BASH has command line options such as `-D` to help with internationalization. Since `xgettext` can handle shell scripts and extract the text after a "keyword", it was felt that using `xgettext` to do this would make it easier to write and maintain the code and international strings.
 * The Makefile is provided to make it easier to see how things are done from start to finish and it allows one to experiment with such.
 * It is recommended that one use a make-like tool to automate processing of internationalized strings.
 * To distribute the shell script to others the following needs to be provided (a) the shell script, e.g., `demo.sh`, and, (b) the locale directory hierarchy, e.g., `./locale/`.
 * [GNU gettext URL](https://www.gnu.org/software/gettext/)
