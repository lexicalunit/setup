* * *
### [`alert`](bin/alert)
```
usage: alert [-qh] [message]

    -h: print usage help
    -q: enable quiet mode (do not generate any sound)
```

* * *
### [`api`](bin/api)
```
usage: api [options] [curl options] 'URI'

Hits the given URI and returns the result as prettified JSON.
options:
    -h: show this usage help
    -n: dry run
    -j: use curl option: -H 'content-type: application/json'

curl options:
The first option that can not be parsed as an option to this script
will be interpreted as the beginning of options to be passed to curl.
Or force the beginning of curl option parsing by passing -- first.
```

* * *
### [`capture`](bin/capture)
```
usage: capture [-h|--help]

Creates a screenshot of selected window on X11.
```

* * *
### [`cloc`](bin/cloc)
```

Usage: cloc [options] <file(s)/dir(s)> | <set 1> <set 2> | <report files>

 Count, or compute differences of, physical lines of source code in the
 given files (may be archives such as compressed tarballs or zip files)
 and/or recursively below the given directories.

 Input Options
   --extract-with=<cmd>      This option is only needed if cloc is unable
                             to figure out how to extract the contents of
                             the input file(s) by itself.
                             Use <cmd> to extract binary archive files (e.g.:
                             .tar.gz, .zip, .Z).  Use the literal '>FILE<' as
                             a stand-in for the actual file(s) to be
                             extracted.  For example, to count lines of code
                             in the input files
                                gcc-4.2.tar.gz  perl-5.8.8.tar.gz
                             on Unix use
                               --extract-with='gzip -dc >FILE< | tar xf -'
                             or, if you have GNU tar,
                               --extract-with='tar zxf >FILE<'
                             and on Windows use, for example:
                               --extract-with="\"c:\Program Files\WinZip\WinZip32.exe\" -e -o >FILE< ."
                             (if WinZip is installed there).
   --list-file=<file>        Take the list of file and/or directory names to
                             process from <file> which has one file/directory
                             name per line.  See also --exclude-list-file.
   --unicode                 Check binary files to see if they contain Unicode
                             expanded ASCII text.  This causes performance to
                             drop noticably.

 Processing Options
   --autoconf                Count .in files (as processed by GNU autoconf) of
                             recognized languages.
   --by-file                 Report results for every source file encountered.
   --by-file-by-lang         Report results for every source file encountered
                             in addition to reporting by language.
   --diff <set1> <set2>      Compute differences in code and comments between
                             source file(s) of <set1> and <set2>.  The inputs
                             may be pairs of files, directories, or archives.
                             Use --diff-alignment to generate a list showing
                             which file pairs where compared.  See also
                             --ignore-case, --ignore-whitespace.
   --diff-timeout <N>        Ignore files which take more than <N> seconds
                             to process.  Default is 10 seconds.
                             (Large files with many repeated lines can cause
                             Algorithm::Diff::sdiff() to take hours.)
   --follow-links            [Unix only] Follow symbolic links to directories
                             (sym links to files are always followed).
   --force-lang=<lang>[,<ext>]
                             Process all files that have a <ext> extension
                             with the counter for language <lang>.  For
                             example, to count all .f files with the
                             Fortran 90 counter (which expects files to
                             end with .f90) instead of the default Fortran 77
                             counter, use
                               --force-lang="Fortran 90",f
                             If <ext> is omitted, every file will be counted
                             with the <lang> counter.  This option can be
                             specified multiple times (but that is only
                             useful when <ext> is given each time).
                             See also --script-lang, --lang-no-ext.
   --force-lang-def=<file>   Load language processing filters from <file>,
                             then use these filters instead of the built-in
                             filters.  Note:  languages which map to the same
                             file extension (for example:
                             MATLAB/Objective C/MUMPS;  Pascal/PHP;
                             Lisp/OpenCL) will be ignored as these require
                             additional processing that is not expressed in
                             language definition files.  Use --read-lang-def
                             to define new language filters without replacing
                             built-in filters (see also --write-lang-def).
   --ignore-whitespace       Ignore horizontal white space when comparing files
                             with --diff.  See also --ignore-case.
   --ignore-case             Ignore changes in case; consider upper- and lower-
                             case letters equivalent when comparing files with
                             --diff.  See also --ignore-whitespace.
   --lang-no-ext=<lang>      Count files without extensions using the <lang>
                             counter.  This option overrides internal logic
                             for files without extensions (where such files
                             are checked against known scripting languages
                             by examining the first line for #!).  See also
                             --force-lang, --script-lang.
   --max-file-size=<MB>      Skip files larger than <MB> megabytes when
                             traversing directories.  By default, <MB>=100.
                             cloc's memory requirement is roughly twenty times
                             larger than the largest file so running with
                             files larger than 100 MB on a computer with less
                             than 2 GB of memory will cause problems.
                             Note:  this check does not apply to files
                             explicitly passed as command line arguments.
   --read-binary-files       Process binary files in addition to text files.
                             This is usually a bad idea and should only be
                             attempted with text files that have embedded
                             binary data.
   --read-lang-def=<file>    Load new language processing filters from <file>
                             and merge them with those already known to cloc.
                             If <file> defines a language cloc already knows
                             about, cloc's definition will take precedence.
                             Use --force-lang-def to over-ride cloc's
                             definitions (see also --write-lang-def ).
   --script-lang=<lang>,<s>  Process all files that invoke <s> as a #!
                             scripting language with the counter for language
                             <lang>.  For example, files that begin with
                                #!/usr/local/bin/perl5.8.8
                             will be counted with the Perl counter by using
                                --script-lang=Perl,perl5.8.8
                             The language name is case insensitive but the
                             name of the script language executable, <s>,
                             must have the right case.  This option can be
                             specified multiple times.  See also --force-lang,
                             --lang-no-ext.
   --sdir=<dir>              Use <dir> as the scratch directory instead of
                             letting File::Temp chose the location.  Files
                             written to this location are not removed at
                             the end of the run (as they are with File::Temp).
   --skip-uniqueness         Skip the file uniqueness check.  This will give
                             a performance boost at the expense of counting
                             files with identical contents multiple times
                             (if such duplicates exist).
   --stdin-name=<file>       Give a file name to use to determine the language
                             for standard input.
   --strip-comments=<ext>    For each file processed, write to the current
                             directory a version of the file which has blank
                             lines and comments removed.  The name of each
                             stripped file is the original file name with
                             .<ext> appended to it.  It is written to the
                             current directory unless --original-dir is on.
   --original-dir            [Only effective in combination with
                             --strip-comments]  Write the stripped files
                             to the same directory as the original files.
   --sum-reports             Input arguments are report files previously
                             created with the --report-file option.  Makes
                             a cumulative set of results containing the
                             sum of data from the individual report files.
   --unix                    Override the operating system autodetection
                             logic and run in UNIX mode.  See also
                             --windows, --show-os.
   --windows                 Override the operating system autodetection
                             logic and run in Microsoft Windows mode.
                             See also --unix, --show-os.

 Filter Options
   --exclude-dir=<D1>[,D2,]  Exclude the given comma separated directories
                             D1, D2, D3, et cetera, from being scanned.  For
                             example  --exclude-dir=.cache,test  will skip
                             all files that have /.cache/ or /test/ as part
                             of their path.
                             Directories named .bzr, .cvs, .hg, .git, and
                             .svn are always excluded.
   --exclude-ext=<ext1>[,<ext2>[...]]
                             Do not count files having the given file name
                             extensions.
   --exclude-lang=<L1>[,L2,] Exclude the given comma separated languages
                             L1, L2, L3, et cetera, from being counted.
   --exclude-list-file=<file>  Ignore files and/or directories whose names
                             appear in <file>.  <file> should have one entry
                             per line.  Relative path names will be resolved
                             starting from the directory where cloc is
                             invoked.  See also --list-file.
   --match-d=<regex>         Only count files in directories matching the Perl
                             regex.  For example
                               --match-d='/(src|include)/'
                             only counts files in directories containing
                             /src/ or /include/.
   --not-match-d=<regex>     Count all files except those in directories
                             matching the Perl regex.
   --match-f=<regex>         Only count files whose basenames match the Perl
                             regex.  For example
                               --match-f='^[Ww]idget'
                             only counts files that start with Widget or widget.
   --not-match-f=<regex>     Count all files except those whose basenames
                             match the Perl regex.
   --skip-archive=<regex>    Ignore files that end with the given Perl regular
                             expression.  For example, if given
                               --skip-archive='(zip|tar(.(gz|Z|bz2|xz|7z))?)'
                             the code will skip files that end with .zip,
                             .tar, .tar.gz, .tar.Z, .tar.bz2, .tar.xz, and
                             .tar.7z.
   --skip-win-hidden         On Windows, ignore hidden files.

 Debug Options
   --categorized=<file>      Save names of categorized files to <file>.
   --counted=<file>          Save names of processed source files to <file>.
   --explain=<lang>          Print the filters used to remove comments for
                             language <lang> and exit.  In some cases the
                             filters refer to Perl subroutines rather than
                             regular expressions.  An examination of the
                             source code may be needed for further explanation.
   --diff-alignment=<file>   Write to <file> a list of files and file pairs
                             showing which files were added, removed, and/or
                             compared during a run with --diff.  This switch
                             forces the --diff mode on.
   --help                    Print this usage information and exit.
   --found=<file>            Save names of every file found to <file>.
   --ignored=<file>          Save names of ignored files and the reason they
                             were ignored to <file>.
   --print-filter-stages     Print processed source code before and after
                             each filter is applied.
   --show-ext[=<ext>]        Print information about all known (or just the
                             given) file extensions and exit.
   --show-lang[=<lang>]      Print information about all known (or just the
                             given) languages and exit.
   --show-os                 Print the value of the operating system mode
                             and exit.  See also --unix, --windows.
   -v[=<n>]                  Verbose switch (optional numeric value).
   --version                 Print the version of this program and exit.
   --write-lang-def=<file>   Writes to <file> the language processing filters
                             then exits.  Useful as a first step to creating
                             custom language definitions (see also
                             --force-lang-def, --read-lang-def).

 Output Options
   --3                       Print third-generation language output.
                             (This option can cause report summation to fail
                             if some reports were produced with this option
                             while others were produced without it.)
   --progress-rate=<n>       Show progress update after every <n> files are
                             processed (default <n>=100).  Set <n> to 0 to
                             suppress progress output (useful when redirecting
                             output to STDOUT).
   --quiet                   Suppress all information messages except for
                             the final report.
   --report-file=<file>      Write the results to <file> instead of STDOUT.
   --out=<file>              Synonym for --report-file=<file>.
   --csv                     Write the results as comma separated values.
   --csv-delimiter=<C>       Use the character <C> as the delimiter for comma
                             separated files instead of ,.  This switch forces
                             --csv to be on.
   --sql=<file>              Write results as SQL create and insert statements
                             which can be read by a database program such as
                             SQLite.  If <file> is -, output is sent to STDOUT.
   --sql-project=<name>      Use <name> as the project identifier for the
                             current run.  Only valid with the --sql option.
   --sql-append              Append SQL insert statements to the file specified
                             by --sql and do not generate table creation
                             statements.  Only valid with the --sql option.
   --sum-one                 For plain text reports, show the SUM: output line
                             even if only one input file is processed.
   --xml                     Write the results in XML.
   --xsl=<file>              Reference <file> as an XSL stylesheet within
                             the XML output.  If <file> is 1 (numeric one),
                             writes a default stylesheet, cloc.xsl (or
                             cloc-diff.xsl if --diff is also given).
                             This switch forces --xml on.
   --yaml                    Write the results in YAML.
```

* * *
### [`colortest`](bin/colortest)
```
usage: colortest

Prints out table of terminal color codes.
```

* * *
### [`die`](bin/die)
```
usage: die [options] REGEX

kills all processes matching REGEX.

options:
 -n enables dryrun mode
 -q enables quite mode
 -h or --help shows usage help
```

* * *
### [`fa`](bin/fa)
```
usage: fa [-h|--help] [python regex]

Finds All (fa) occurrences of the given regex using grin to search source files,
ignoring directories: CVS, RCS, .svn, .hg, .bzr, .git, build, dist, CMakeFiles
and ignoring file extensions: .pyc, .pyo, .so, .o, .a, .tgz, .tar.gz, .rar, .zip, ~, #, .bak, .png, .jpg, .gif, .bmp, .tif, .tiff, .pyd, .dll, .exe, .obj, .lib, cmake, Makefile

usage: grin [-h] [-v] [-i] [-A AFTER_CONTEXT] [-B BEFORE_CONTEXT] [-C CONTEXT]
            [-I INCLUDE] [-n] [-N] [-H] [--without-filename] [--emacs] [-l]
            [-L] [--no-color] [--use-color] [--force-color] [-s]
            [--skip-hidden-files] [-b] [--skip-backup-files] [-S]
            [--skip-hidden-dirs] [-d SKIP_DIRS] [-D] [-e SKIP_EXTS] [-E]
            [--no-follow] [--follow] [-f FILE] [-0] [--sys-path]
            regex [files [files ...]]

Search text files for a given regex pattern.

positional arguments:
  regex                 the regular expression to search for
  files                 the files to search

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -i, --ignore-case     ignore case in the regex
  -A AFTER_CONTEXT, --after-context AFTER_CONTEXT
                        the number of lines of context to show after the match
                        [default=0]
  -B BEFORE_CONTEXT, --before-context BEFORE_CONTEXT
                        the number of lines of context to show before the
                        match [default=0]
  -C CONTEXT, --context CONTEXT
                        the number of lines of context to show on either side
                        of the match
  -I INCLUDE, --include INCLUDE
                        only search in files matching this glob [default='*']
  -n, --line-number     show the line numbers [default]
  -N, --no-line-number  do not show the line numbers
  -H, --with-filename   show the filenames of files that match [default]
  --without-filename    do not show the filenames of files that match
  --emacs               print the filename with every match for easier parsing
                        by e.g. Emacs
  -l, --files-with-matches
                        show only the filenames and not the texts of the
                        matches
  -L, --files-without-matches
                        show the matches with the filenames
  --no-color            do not use colorized output [default if piping the
                        output]
  --use-color           use colorized output [default if outputting to a
                        terminal]
  --force-color         always use colorized output even when piping to
                        something that may not be able to handle it
  -s, --no-skip-hidden-files
                        do not skip .hidden files
  --skip-hidden-files   do skip .hidden files [default]
  -b, --no-skip-backup-files
                        do not skip backup~ files [deprecated; edit --skip-
                        exts]
  --skip-backup-files   do skip backup~ files [default] [deprecated; edit
                        --skip-exts]
  -S, --no-skip-hidden-dirs
                        do not skip .hidden directories
  --skip-hidden-dirs    do skip .hidden directories [default]
  -d SKIP_DIRS, --skip-dirs SKIP_DIRS
                        comma-separated list of directory names to skip
                        [default='CVS,RCS,.svn,.hg,.bzr,build,dist']
  -D, --no-skip-dirs    do not skip any directories
  -e SKIP_EXTS, --skip-exts SKIP_EXTS
                        comma-separated list of file extensions to skip [defau
                        lt='.pyc,.pyo,.so,.o,.a,.tgz,.tar.gz,.rar,.zip,~,#,.ba
                        k,.png,.jpg,.gif,.bmp,.tif,.tiff,.pyd,.dll,.exe,.obj,.
                        lib']
  -E, --no-skip-exts    do not skip any file extensions
  --no-follow           do not follow symlinks to directories and files
                        [default]
  --follow              follow symlinks to directories and files
  -f FILE, --files-from-file FILE
                        read files to search from a file, one per line; - for
                        stdin
  -0, --null-separated  filenames specified in --files-from-file are separated
                        by NULs
  --sys-path            search the directories on sys.path

Bug reports to <enthought-dev@mail.enthought.com>.
```

* * *
### [`ff`](bin/ff)
Symbolic link to '/usr/local/bin/grind'
```
usage: ff [-h] [-v] [-s] [--skip-hidden-files] [-b] [--skip-backup-files] [-S]
          [--skip-hidden-dirs] [-d SKIP_DIRS] [-D] [-e SKIP_EXTS] [-E]
          [--no-follow] [--follow] [-0] [--dirs DIRS [DIRS ...]] [--sys-path]
          [glob]

Find text and binary files using similar rules as grin.

positional arguments:
  glob                  the glob pattern to match; you may need to quote this
                        to prevent the shell from trying to expand it
                        [default='*']

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -s, --no-skip-hidden-files
                        do not skip .hidden files
  --skip-hidden-files   do skip .hidden files
  -b, --no-skip-backup-files
                        do not skip backup~ files [deprecated; edit --skip-
                        exts]
  --skip-backup-files   do skip backup~ files [default] [deprecated; edit
                        --skip-exts]
  -S, --no-skip-hidden-dirs
                        do not skip .hidden directories
  --skip-hidden-dirs    do skip .hidden directories
  -d SKIP_DIRS, --skip-dirs SKIP_DIRS
                        comma-separated list of directory names to skip
                        [default='CVS,RCS,.svn,.hg,.bzr,build,dist']
  -D, --no-skip-dirs    do not skip any directories
  -e SKIP_EXTS, --skip-exts SKIP_EXTS
                        comma-separated list of file extensions to skip [defau
                        lt='.pyc,.pyo,.so,.o,.a,.tgz,.tar.gz,.rar,.zip,~,#,.ba
                        k,.png,.jpg,.gif,.bmp,.tif,.tiff,.pyd,.dll,.exe,.obj,.
                        lib']
  -E, --no-skip-exts    do not skip any file extensions
  --no-follow           do not follow symlinks to directories and files
                        [default]
  --follow              follow symlinks to directories and files
  -0, --null-separated  print the filenames separated by NULs
  --dirs DIRS [DIRS ...]
                        the directories to start from
  --sys-path            search the directories on sys.path

Bug reports to <enthought-dev@mail.enthought.com>.
```

* * *
### [`flip`](bin/flip)
```
usage: echo 'text' | flip

Literally flips input upside down, printing words so they appear to be flipped over.
```

* * *
### [`fm`](bin/fm)
```
usage: fm [-h|--help] [grep pattern]

Recursively Finds given pattern within CMake files.
```

* * *
### [`git_push_topic`](bin/git_push_topic)
```
usage: git_push_topic [-h|--help]
Preforms command 'git push -fu origin $BRANCH', force pushing feature branch up to remote origin.
```

* * *
### [`install`](bin/install)
```
usage: install
Installs setup/bin tools into user's ~/bin directory.
```

* * *
### [`install_atom`](bin/install_atom)
```
usage: install_atom [-h|--help]
Installs Atom IDE including packages and editor configuration.
The following atom packages are included:

    atom-soda-dark-ui
    autocomplete-plus
    linter
    linter-flake8
    linter-shellcheck
    merge-conflicts
    minimap
    minimap-git-diff
    minimap-selection
    monokai-soda
    red-wavy-underline
    set-syntax
    sort-lines
    tabs-to-spaces
```

* * *
### [`install_dev`](bin/install_dev)
```
usage: install_dev [-l|-d|-f|-h|--help] [all|step-name]
Automatically installs and configures a complete OS X developer environment.

options:
    -h, --help: show usage help
    -l: list available step names
    -d: dry-run
    -f: force install, do not ask for any confirmation
    all: executes all steps
    step-name: execute only the given step

steps:
    xcode: Check that Command Line Tools are installed
    brew: Upgrade/Install Homebrew formulas
    checkbrew: Check for additional or missing Homebrew packages
    python: Upgrade/Install Anaconda, pip packages, and conda packages
    java: Check that java is installed (will prompt to install if not)
    gem: Upgrade/Install gem packages + rubygems-update package
    xquartz: Install latest XQuartz package
    bash: Install latest version of bash from Homebrew
    zsh: Install latest version of zsh from Homebrew
    tiddlywiki: Install and setup latest TiddlyWiki from Homebrew

Homebrew Formulas: autoconf, boost, cmake, coreutils, cppunit, dmd, doxygen, fontconfig, freetype, 
ghostscript, git, gnu-sed, imagemagick, jbig2dec, jpeg, libevent, yaml-cpp, 
libpng, libtiff, libtool, libyaml, little-cms2, maven, memcached, mercurial, 
mongodb, ncftp, node, openssl, ossp-uuid, pcre, pidof, pkg-config, plotutils, 
postgresql, wget, readline, ruby, s3cmd, scons, spark, sqlite, unixodbc, unrar, 
watch, xz, libmpc, geoip, shellcheck, tree, youtube-dl

Pip Packages: bson, pymongo, fabric, iniparse, psycopg2, oauth2client, pytz, suds, 
google-api-python-client, httplib2, tinycss, termcolor, requests, uritemplate, 
beautifulsoup4, pyflakes, pep8, flake8

Conda Packages: dateutil, pyzmq, argcomplete

Gem Packages: cap_gun, archive-tar-minitar, bson, bson_ext, bundler, bundler-unload, 
childprocess, cuba, erector, gem-wrappers, jekyll, jewelbox, log4r, lolcat, 
mongo, net-ldap, rack, rack-protection, railsless-deploy, rubygems-bundler, 
rvm, shotgun, yajl-ruby, capistrano
```

* * *
### [`install_mysql`](bin/install_mysql)
```
usage: install_mysql [-h|--help] [uninstall]
If the 'uninstall' command is given, uninstalls MySQL instead.
```

* * *
### [`jsc`](bin/jsc)
Symbolic link to '/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc'
```
Usage: jsc [options] [files] [-- arguments]
  -d         Dumps bytecode (debug builds only)
  -e         Evaluate argument as script code
  -f         Specifies a source file (deprecated)
  -h|--help  Prints this help message
  -i         Enables interactive mode (default if no files are specified)
  -s         Installs signal handlers that exit on a crash (Unix platforms only)
  -p <file>  Outputs profiling data to a file
  -x         Output exit code before terminating

  --options                  Dumps all JSC VM options and exits
  --dumpOptions              Dumps all JSC VM options before continuing
  --<jsc VM option>=<value>  Sets the specified JSC VM option
```

* * *
### [`lt`](bin/lt)
```
usage: lt DURATION CMD [ARG]

A limited bash version of the GNU tool timeout. Use timeout if you have it.
```

* * *
### [`macosver`](bin/macosver)
```
usage: macosver

Simply prints out the OS X major and minor version.
```

* * *
### [`nopw`](bin/nopw)
```
usage: nopw [-h|-help] [ssh connection options] username@remotehost
Puts your public ssh key in the authorized_keys on the remote host.
```

* * *
### [`reauthor`](bin/reauthor)
```
usage: reauthor [-f] commit-to-change [branch-to-rewrite [new-name [new-email]]]

  If -f is supplied it is passed to 'git filter-branch'.

  If <branch-to-rewrite> is not provided or is empty HEAD will be used.
  Use '--all' or a space separated list (e.g. 'master next') to rewrite
  multiple branches.

  If <new-name> (or <new-email>) is not provided or is empty, the normal
  user.name (user.email) Git configuration value will be used.
```

* * *
### [`root`](bin/root)
```
usage: root [-h|--help]
Prints the root directory of the current source repository.
```

* * *
### [`s`](bin/s)
```
usage: s [-h|--help] [git command]
Print out the git status, or given command, of all subdirectories of the current directory.
```

* * *
### [`safari_cache`](bin/safari_cache)
```
usage: safari_cache [-h|--help]
Generates and displays a webpage displaying Safari's cache.
```

* * *
### [`safari_clean`](bin/safari_clean)
```
usage: safari_clean [-h|--help]
Cleans Safari caches and saved data on OS X.
Use 'yes | safari_clean' to auto-confirm the cleaning of everything.
```

* * *
### [`setup_odbc`](bin/setup_odbc)
```
usage: setup_odbc [-h|--help]
Attempts to install a working ODBC configuration to OS X.
Uses unixODBC with FreeTDS from Homebrew.
Requires hand editing to support your specific installation.
```

* * *
### [`share`](bin/share)
```
usage share [<file>|ls|names|ssh|get <name>|put <file>|rm <name>]
Requires ~/.webshare script be created for your webshare configuration.

The ~/.webshare script must set environment variables:
 * USER - user to use when connecting to HOST
 * HOST - the hostname to connect to
 * DEST_ROOT - the root of the www_html directory on HOST
 * DEST_DIR - the shares directory within the www_html directory
```

* * *
### [`slept`](bin/slept)
```
usage: slept [-h|--help]
Uses sysctl to discover when the last time OS X slept was.
```

* * *
### [`smongo`](bin/smongo)
```
usage: smongo HOST

Discovers and then connects mongo shell to the cluster master node.
```

* * *
### [`subl`](bin/subl)
Symbolic link to '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'
```
Sublime Text build 3065

Usage: subl [arguments] [files]         edit the given files
   or: subl [arguments] [directories]   open the given directories
   or: subl [arguments] -               edit stdin

Arguments:
  --project <project>: Load the given project
  --command <command>: Run the given command
  -n or --new-window:  Open a new window
  -a or --add:         Add folders to the current window
  -w or --wait:        Wait for the files to be closed before returning
  -b or --background:  Don't activate the application
  -s or --stay:        Keep the application activated after closing the file
  -h or --help:        Show help (this message) and exit
  -v or --version:     Show version and exit

--wait is implied if reading from stdin. Use --stay to not switch back
to the terminal when a file is closed (only relevant if waiting for a file).

Filenames may be given a :line or :line:column suffix to open at a specific
location.
```

* * *
### [`uninstall_homebrew`](bin/uninstall_homebrew)
```
usage: uninstall_homebrew [-h|--help]
See https://gist.github.com/1173223 for details.
```

* * *
### [`uninstall_macports`](bin/uninstall_macports)
```
usage: uninstall_macports [-h|--help]
See http://guide.macports.org/chunked/installing.macports.uninstalling.html for details.
```

* * *
### [`update_bin`](bin/update_bin)
```
usage: update_bin [-h|--help]
Copies scripts in ~/bin into ./bin. Honors ignore file.
```

* * *
### [`usages`](bin/usages)
```
usage: usages [-h|--help]
Prints out documentation and usage information for everything in current directory.
```

* * *
### [`woke`](bin/woke)
```
usage: woke [-h|--help]
Uses sysctl to discover when the last time OS X woke was.
```

* * *
### [`xdie`](bin/xdie)
```
usage: xdie [-p|-h|--help] REGEX
Kills all windows matching REGEX. Use -p for pretend mode.
```

* * *
### [`xf`](bin/xf)
```
usage: xf <archive> - extract common file formats
```

* * *
### [`yaml2json`](bin/yaml2json)
```
usage: yaml2json < file.yaml
Takes YAML input and pretty prints conversion to JSON format.
```

* * *
### [`youtube2mp3`](bin/youtube2mp3)
```
usage: youtube2mp3 [-h|--help] [youtube-dl options] <youtube URL>

Downloads the youtube video at the given URL and creates corresponding mp3.
Uses the tool youtube-dl to do it's dirty work, so make sure that it's installed and up to date.

Usage: youtube-dl [options] url [url...]

Options:
  General Options:
    -h, --help                       print this help text and exit
    --version                        print program version and exit
    -U, --update                     update this program to latest version. Make sure that you have sufficient permissions (run with sudo if needed)
    -i, --ignore-errors              continue on download errors, for example to skip unavailable videos in a playlist
    --abort-on-error                 Abort downloading of further videos (in the playlist or the command line) if an error occurs
    --dump-user-agent                display the current browser identification
    --list-extractors                List all supported extractors and the URLs they would handle
    --extractor-descriptions         Output descriptions of all supported extractors
    --proxy URL                      Use the specified HTTP/HTTPS proxy. Pass in an empty string (--proxy "") for direct connection
    --socket-timeout None            Time to wait before giving up, in seconds
    --default-search PREFIX          Use this prefix for unqualified URLs. For example "gvsearch2:" downloads two videos from google videos for  youtube-dl "large
                                     apple". Use the value "auto" to let youtube-dl guess ("auto_warning" to emit a warning when guessing). "error" just throws an
                                     error. The default value "fixup_error" repairs broken URLs, but emits an error if this is not possible instead of searching.
    --ignore-config                  Do not read configuration files. When given in the global configuration file /etc/youtube-dl.conf: do not read the user
                                     configuration in ~/.config/youtube-dl.conf (%APPDATA%/youtube-dl/config.txt on Windows)
    --flat-playlist                  Do not extract the videos of a playlist, only list them.

  Video Selection:
    --playlist-start NUMBER          playlist video to start at (default is 1)
    --playlist-end NUMBER            playlist video to end at (default is last)
    --match-title REGEX              download only matching titles (regex or caseless sub-string)
    --reject-title REGEX             skip download for matching titles (regex or caseless sub-string)
    --max-downloads NUMBER           Abort after downloading NUMBER files
    --min-filesize SIZE              Do not download any videos smaller than SIZE (e.g. 50k or 44.6m)
    --max-filesize SIZE              Do not download any videos larger than SIZE (e.g. 50k or 44.6m)
    --date DATE                      download only videos uploaded in this date
    --datebefore DATE                download only videos uploaded on or before this date (i.e. inclusive)
    --dateafter DATE                 download only videos uploaded on or after this date (i.e. inclusive)
    --min-views COUNT                Do not download any videos with less than COUNT views
    --max-views COUNT                Do not download any videos with more than COUNT views
    --no-playlist                    download only the currently playing video
    --age-limit YEARS                download only videos suitable for the given age
    --download-archive FILE          Download only videos not listed in the archive file. Record the IDs of all downloaded videos in it.
    --include-ads                    Download advertisements as well (experimental)

  Download Options:
    -r, --rate-limit LIMIT           maximum download rate in bytes per second (e.g. 50K or 4.2M)
    -R, --retries RETRIES            number of retries (default is 10)
    --buffer-size SIZE               size of download buffer (e.g. 1024 or 16K) (default is 1024)
    --no-resize-buffer               do not automatically adjust the buffer size. By default, the buffer size is automatically resized from an initial value of SIZE.

  Filesystem Options:
    -a, --batch-file FILE            file containing URLs to download ('-' for stdin)
    --id                             use only video ID in file name
    -A, --auto-number                number downloaded files starting from 00000
    -o, --output TEMPLATE            output filename template. Use %(title)s to get the title, %(uploader)s for the uploader name, %(uploader_id)s for the uploader
                                     nickname if different, %(autonumber)s to get an automatically incremented number, %(ext)s for the filename extension, %(format)s
                                     for the format description (like "22 - 1280x720" or "HD"), %(format_id)s for the unique id of the format (like Youtube's itags:
                                     "137"), %(upload_date)s for the upload date (YYYYMMDD), %(extractor)s for the provider (youtube, metacafe, etc), %(id)s for the
                                     video id, %(playlist)s for the playlist the video is in, %(playlist_index)s for the position in the playlist and %% for a literal
                                     percent. %(height)s and %(width)s for the width and height of the video format. %(resolution)s for a textual description of the
                                     resolution of the video format. Use - to output to stdout. Can also be used to download to a different directory, for example with
                                     -o '/my/downloads/%(uploader)s/%(title)s-%(id)s.%(ext)s' .
    --autonumber-size NUMBER         Specifies the number of digits in %(autonumber)s when it is present in output filename template or --auto-number option is given
    --restrict-filenames             Restrict filenames to only ASCII characters, and avoid "&" and spaces in filenames
    -t, --title                      [deprecated] use title in file name (default)
    -l, --literal                    [deprecated] alias of --title
    -w, --no-overwrites              do not overwrite files
    -c, --continue                   force resume of partially downloaded files. By default, youtube-dl will resume downloads if possible.
    --no-continue                    do not resume partially downloaded files (restart from beginning)
    --no-part                        do not use .part files - write directly into output file
    --no-mtime                       do not use the Last-modified header to set the file modification time
    --write-description              write video description to a .description file
    --write-info-json                write video metadata to a .info.json file
    --write-annotations              write video annotations to a .annotation file
    --write-thumbnail                write thumbnail image to disk
    --load-info FILE                 json file containing the video information (created with the "--write-json" option)
    --cookies FILE                   file to read cookies from and dump cookie jar in
    --cache-dir DIR                  Location in the filesystem where youtube-dl can store some downloaded information permanently. By default $XDG_CACHE_HOME/youtube-
                                     dl or ~/.cache/youtube-dl . At the moment, only YouTube player files (for videos with obfuscated signatures) are cached, but that
                                     may change.
    --no-cache-dir                   Disable filesystem caching
    --rm-cache-dir                   Delete all filesystem cache files

  Verbosity / Simulation Options:
    -q, --quiet                      activates quiet mode
    --no-warnings                    Ignore warnings
    -s, --simulate                   do not download the video and do not write anything to disk
    --skip-download                  do not download the video
    -g, --get-url                    simulate, quiet but print URL
    -e, --get-title                  simulate, quiet but print title
    --get-id                         simulate, quiet but print id
    --get-thumbnail                  simulate, quiet but print thumbnail URL
    --get-description                simulate, quiet but print video description
    --get-duration                   simulate, quiet but print video length
    --get-filename                   simulate, quiet but print output filename
    --get-format                     simulate, quiet but print output format
    -j, --dump-json                  simulate, quiet but print JSON information. See --output for a description of available keys.
    -J, --dump-single-json           simulate, quiet but print JSON information for each command-line argument. If the URL refers to a playlist, dump the whole
                                     playlist information in a single line.
    --newline                        output progress bar as new lines
    --no-progress                    do not print progress bar
    --console-title                  display progress in console titlebar
    -v, --verbose                    print various debugging information
    --dump-intermediate-pages        print downloaded pages to debug problems (very verbose)
    --write-pages                    Write downloaded intermediary pages to files in the current directory to debug problems
    --print-traffic                  Display sent and read HTTP traffic

  Workarounds:
    --encoding ENCODING              Force the specified encoding (experimental)
    --no-check-certificate           Suppress HTTPS certificate validation.
    --prefer-insecure                Use an unencrypted connection to retrieve information about the video. (Currently supported only for YouTube)
    --user-agent UA                  specify a custom user agent
    --referer URL                    specify a custom referer, use if the video access is restricted to one domain
    --add-header FIELD:VALUE         specify a custom HTTP header and its value, separated by a colon ':'. You can use this option multiple times
    --bidi-workaround                Work around terminals that lack bidirectional text support. Requires bidiv or fribidi executable in PATH

  Video Format Options:
    -f, --format FORMAT              video format code, specify the order of preference using slashes: -f 22/17/18 .  -f mp4 , -f m4a and  -f flv  are also supported.
                                     You can also use the special names "best", "bestvideo", "bestaudio", "worst", "worstvideo" and "worstaudio". By default, youtube-
                                     dl will pick the best quality. Use commas to download multiple audio formats, such as  -f  136/137/mp4/bestvideo,140/m4a/bestaudio
    --all-formats                    download all available video formats
    --prefer-free-formats            prefer free video formats unless a specific one is requested
    --max-quality FORMAT             highest quality format to download
    -F, --list-formats               list all available formats
    --youtube-skip-dash-manifest     Do not download the DASH manifest on YouTube videos

  Subtitle Options:
    --write-sub                      write subtitle file
    --write-auto-sub                 write automatic subtitle file (youtube only)
    --all-subs                       downloads all the available subtitles of the video
    --list-subs                      lists all available subtitles for the video
    --sub-format FORMAT              subtitle format (default=srt) ([sbv/vtt] youtube only)
    --sub-lang LANGS                 languages of the subtitles to download (optional) separated by commas, use IETF language tags like 'en,pt'

  Authentication Options:
    -u, --username USERNAME          login with this account ID
    -p, --password PASSWORD          account password
    -2, --twofactor TWOFACTOR        two-factor auth code
    -n, --netrc                      use .netrc authentication data
    --video-password PASSWORD        video password (vimeo, smotri)

  Post-processing Options:
    -x, --extract-audio              convert video files to audio-only files (requires ffmpeg or avconv and ffprobe or avprobe)
    --audio-format FORMAT            "best", "aac", "vorbis", "mp3", "m4a", "opus", or "wav"; "best" by default
    --audio-quality QUALITY          ffmpeg/avconv audio quality specification, insert a value between 0 (better) and 9 (worse) for VBR or a specific bitrate like 128K
                                     (default 5)
    --recode-video FORMAT            Encode the video to another format if necessary (currently supported: mp4|flv|ogg|webm|mkv)
    -k, --keep-video                 keeps the video file on disk after the post-processing; the video is erased by default
    --no-post-overwrites             do not overwrite post-processed files; the post-processed files are overwritten by default
    --embed-subs                     embed subtitles in the video (only for mp4 videos)
    --embed-thumbnail                embed thumbnail in the audio as cover art
    --add-metadata                   write metadata to the video file
    --xattrs                         write metadata to the video file's xattrs (using dublin core and xdg standards)
    --prefer-avconv                  Prefer avconv over ffmpeg for running the postprocessors (default)
    --prefer-ffmpeg                  Prefer ffmpeg over avconv for running the postprocessors
    --exec CMD                       Execute a command on the file after downloading, similar to find's -exec syntax. Example: --exec 'adb push {} /sdcard/Music/ && rm
                                     {}'
```
