# Retrieving and Using Existing International Strings

## First, an example...

Given this BASH script `demo.sh`:

        #!/bin/bash
        COMMAND_NOT_FOUND=$(gettext bash '%s: command not found')
        printf "${COMMAND_NOT_FOUND}\n" 'TESTING'

it produces internationalized output when run (provided `bash` is installed), e.g,

        $ LANGUAGE=en ./demo.sh
        TESTING: command not found
        $ LANGUAGE=fr ./demo.sh
        TESTING : commande introuvable
        $ LANGUAGE=es ./demo.sh
        TESTING: orden no encontrada
        $

### How does this example work?

The example works using `gettext` from the GNU gettext package. BASH uses `gettext` to produce its internationalized output, e.g.,

        $ LANGUAGE=en bash -c 'dsadsa'
        bash: line 1: dsadsa: command not found
        $ LANGUAGE=fr bash -c 'dsadsa'
        bash: ligne 1: dsadsa : commande introuvable
        $ LANGUAGE=es bash -c 'dsadsa'
        bash: línea 1: dsadsa: orden no encontrada
        $ LANGUAGE=zh_CN bash -c 'dsadsa'
        bash:行1: dsadsa：未找到命令

In `/usr/share/locale` there are a number of directories for the various locales installed on that system. For the tools using GNU gettext, there will be a `.mo` file for each installed locale file for a particular program. Typically the `.mo` file's base name will be the name of that program, e.g., `bash.mo`. Thus, searching for the `bash.mo` files in `/usr/share/locale` will show you all of the locales BASH has locale files for on that system, e.g.,

        $ find /usr/share/locale/ -type f -name 'bash.mo'

With GNU gettext, each item is looked up with a `msgid` string and if there is a match, a `msgstr` string value is returned. Thus, the `gettext` command run below will output BASH's command not found error message using the appropriate `bash.mo` file installed on that system:

        $ printf "$(gettext bash '%s: command not found')\n" SOMESTRING

## How to Find and Use the Appropriate `msgid`

Suppose you know a specific tool outputs a locale-specific error message, e.g., BASH does:

        $ LANGUAGE=en bash -c 'dsadsa'
        bash: line 1: dsadsa: command not found
        $ LANGUAGE=fr bash -c 'dsadsa'
        bash: ligne 1: dsadsa : commande introuvable
        $ LANGUAGE=es bash -c 'dsadsa'
        bash: línea 1: dsadsa: orden no encontrada
        $ LANGUAGE=zh_CN bash -c 'dsadsa'
        bash:行1: dsadsa：未找到命令

This means suitable `.mo` files exist for BASH and these will be found in `/usr/share/locale`. Select a language, e.g., `en`, and search for a suitable BASH file by running:

        $ find /usr/share/locale/ -type f -name bash.mo | grep en

Select one of the files that are listed (if no files are listed then search for another language) and run `msgunfmt` on it, e.g.,

        $ msgunfmt /usr/share/locale/en@quot/LC_MESSAGES/bash.mo | less -S

The output of `msgunfmt` will contain lines starting with `msgid` immediately followed by lines starting with `msgstr`. Search for a part of the message previously seen output, e.g., `command not found`. When a suitable `msgstr` line has been identified, the line before it has that string's `msgid`, e.g., BASH's `command not found` string appears as:

        msgid "%s: command not found"
        msgstr "%s: command not found"

in English and with the French `bash.mo` file, it appears as:

        msgid "%s: command not found"
        msgstr "%s : commande introuvable"

i.e., searching for `commande introuvable` would be used to perform the search using French instead of English. 

After having found the desired `msgstr`, use the `msgid` in the preceding line exactly as it appears with the `gettext` shell command to output it, e.g.,

        $ gettext bash '%s: command not found'

to output the text associated with `'%s: command not found'` and this to output `fr` locale's text:

        $ LANGUAGE=fr gettext '%s: command not found'

(Typically locale-specific environment variables have already been set on that system.)

If there is no matching string, then `gettext` will output the `msgid` string --and often the `msgid` string is the English text (but not always).

## Final Comments

Using the strings from other tools may be appropriate especially if one is using the tool that publishes those strings (and the `msgid` values with that tool are know to be unchanging), e.g., using BASH's `.mo` files from within in a BASH script.

In general, however, it is better to create one's own `.mo` files use those. The `.mo` files do not have to be placed in the system-wide location for locales: they can be placed in a locale subdirectory where the script is located or any other location. A demonstration of how to do this is provided in a subdirectory, `writing-i18n-scripts`, relative to this file.
