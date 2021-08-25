#
# The script is "demo.sh" and the PROJECT_NAME used below is "demo".
# Other variables will append extensions.
#
# The .pot file is a template file built pased on the strings in demo.sh.
#
# The .po files are each language's translations.
#   NOTE: This script used sed to create en and fr versions in the demo.
#
# The .mo files are each .mo file compiled.
#   NOTE: Each of these files is placed in a locale subdirectory.
#         The locale/ directory name can change (provided TEXTDOMAINDIR
#         in the script is modified) but the rest of the directory
#         structure must remain intact.
#
# The gettext and xgettext commands are part of GNU gettext. This
# package is typically installed in Linux.
#   URL: https://www.gnu.org/software/gettext/
#
# To see the demo run "make".
#

PROJECT_NAME=demo
PROJECT_POT=$(PROJECT_NAME).pot
PROJECT_PO=$(PROJECT_NAME).po
PROJECT_MO=$(PROJECT_NAME).mo
PROJECT_SH=$(PROJECT_NAME).sh

.PHONY: all clean create-pot create-en-po create-fr-po create-po-files compile-en-mo compile-fr-mo compile-mo-files

all: clean run

clean:
	rm -rf po/ locale/
	@echo -e "Finished cleaning .pot file.\n"

# Rule to demonstrate a working example...
create-pot: po/$(PROJECT_POT) 
	@echo -e "Finished creating .pot file.\n"

create-en-po: po/en/$(PROJECT_PO) create-pot
	sed -i '/msgid "hello"/!b;n;cmsgstr "Hello World!"' $<

create-fr-po: po/fr/$(PROJECT_PO) create-pot
	sed -i '/msgid "hello"/!b;n;cmsgstr "Bonjour le monde!"' $<

create-po-files: create-en-po create-fr-po
	@echo -e "Finished creating .po files.\n"

compile-en-mo: create-en-po locale/en/LC_MESSAGES/$(PROJECT_MO)
compile-fr-mo: create-fr-po locale/fr/LC_MESSAGES/$(PROJECT_MO)
compile-mo-files: compile-en-mo compile-fr-mo
	@echo -e "Finished compiling .mo files.\n"

run: compile-mo-files
	@echo -e "\nUsing LANGUAGE settings from environment..."
	./$(PROJECT_SH)
	@echo "Using explicitly set LANGUAGE settings..."
	LANGUAGE=C ./$(PROJECT_SH)
	LANGUAGE=en ./$(PROJECT_SH)
	LANGUAGE=en_CA ./$(PROJECT_SH)
	LANGUAGE=fr ./$(PROJECT_SH)
	LANGUAGE=fr_CA ./$(PROJECT_SH)
	LANGUAGE=es ./$(PROJECT_SH)

# Rule to create .pot file from script $(PROJECT_NAME).sh ...
po/$(PROJECT_POT): $(PROJECT_SH)
	@echo "Creating $@ from $< ..."
	mkdir -p po/
	xgettext --keyword=i18n_msgid -k --language=Shell --add-comments --sort-output -o $@ $<
	sed -i 's/=CHARSET/=UTF-8/' $@
	@echo "IMPORTANT: $@ needs to be edited before making other .po files!"

# Rule to create .po file from .pot file...
po/%/$(PROJECT_PO): po/$(PROJECT_POT)
	@echo "Creating $@ from $< ..."
	VAR=$$(basename $$(dirname "$@")) && \
		mkdir -p po/"$$VAR"/ && \
		msginit --input=$< --locale="$$VAR" --output=po/"$$VAR"/$(PROJECT_PO) \
			--no-translator
	@echo "IMPORTANT: Add translations to $@ !"

# Rule to create locale/ structure with a compiled message catalog...
locale/%/LC_MESSAGES/$(PROJECT_MO): po/%/$(PROJECT_PO)
	@echo "Building $@ from $< ..."
	mkdir -p $$(dirname "$@")
	msgfmt -c --output-file="$@" $<
