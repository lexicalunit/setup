# Synopsis

I hate installing, configuring, and updating software on my computer. For example when I'm using a
new machine, or sshing into a remote system. I've automated as much of that process as I can,
keeping everything as lightweight as possible.

## Do everything

Configure and install everything:

```bash
cd && curl -LOks https://github.com/lexicalunit/dotfiles/tarball/master
tar xvzf master --strip 1 -C . && rm master
bin/equip -f dotfiles
bin/equip -f all
```

## Usage

1. Clone this repository into your home directory.
1. Source your new environment by opening a new terminal or running [`. ~/.profile`](.profile).
1. Execute the command [`equip all`](bin/equip) to step through configuration of system settings,
   installation of applications, and creation of your complete developer environment.

You can also use the tool [`bin/deploy_dotfiles`](bin/deploy_dotfiles) to automatically
export these settings to a remote machine.

## Maintenance

* Your home directory is a git repository now! Track changes and commit updates as needed.
* There are some git hooks in [`env`](env) that generate certain files for you.
* Re-run [`equip all`](bin/equip) periodically to update applications and configuration.
* Don't forget to `git pull` any updates!

## Environment: `~/env`

* `Solarized Light.itermcolors` and
  `Solarized Light xterm-256color.terminal`
  themes to use in `Terminal.app` or [`iTerm.app`](http://iterm2.com/).
* `com.googlecode.iterm2.plist` are my settings for [`iTerm.app`](http://iterm2.com/).
* [`Rio.jpg`](env/Rio.jpg) is my favorite Desktop image.
* [`Inconsolata.otf`](env/Inconsolata.otf) is my favorite font for writing code,
  it's automatically installed during the `bin/equip env` step.
* The [`post-commit`](env/post-commit) and [`pre-commit`](env/pre-commit) files are git hooks
  use to maintain this repository. They're also installed as part of the `bin/equip env` step.
* [`prompt_lexical_setup`](env/prompt_lexical_setup) is my
  [prezto](https://github.com/sorin-ionescu/prezto) prompt theme, installed as part of the
  `bin/equip env` step.
* [`nice.css`](env/nice.css) is a nice style sheet useful for overriding annoying websites.
* [`dircolors_examples.tgz`](env/dircolors_examples.tgz) is used by
  [`bin/show_dircolors`](bin/show_dircolors).

## Utilities: `~/bin`

Installed into your [`~/bin`](bin) directory, these tools will be on your `PATH`. For detailed usage
documentation see the [`README.md` for `~/bin`](bin/README.md), or of course run any of the tools
with the argument `--help`.

> **Note:** Some scripts in this repository are written assuming that you're using
> [zsh](http://www.zsh.org/) as your shell. As of
> [macOS Catalina](https://support.apple.com/en-us/HT208050) the default shell is `zsh`.
> However, most scripts in `~/bin` are written with a `/bin/bash`
> [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) because I like to use
> [shellcheck](https://github.com/koalaman/shellcheck) to ensure code quality. Where possible I've
> tried to maintain backwards compatibility with `bash`, but I make no guarantees. You should start
> using `zsh` as soon as possible. It's so much better. In the future there will hopefully be
> [direct support](https://github.com/koalaman/shellcheck/issues/809)
> for `#!/usr/bin/env zsh` in `shellcheck`.

| Tool | Usage |
| --- | --- |
| [`alert`](bin/alert) | Provides shell level windowed alerting system. |
| [`backmost`](bin/backmost) | Send the current frontmost windowed macOS application to the back. |
| [`br`](bin/br) | Reset blinkstick files. |
| [`busy`](bin/busy) | Turn on a busy light. |
| [`capture_x`](bin/capture_x) | Creates a screenshot of selected window on X11. |
| [`cleanup`](bin/cleanup) | Cleans system and application caches on macOS. |
| [`codeclimate`](bin/codeclimate) | Runs Code Climate on the current working directory. |
| [`colortest`](bin/colortest) | Prints out an entire color palette of terminal color codes. |
| [`daemons`](bin/daemons) | Finds and removes unwanted daemons and agents. |
| [`deploy_dotfiles`](bin/deploy_dotfiles) | Installs bin and env from this repository to remote server via ssh. |
| [`die`](bin/die) | Kills processes based on process name. |
| [`doc`](bin/doc) | Builds HTML output from Markdown file. |
| [`dogs`](bin/dogs) | Streams system logs for docker containers. |
| [`equip`](bin/equip) | Install applications and development environment on an macOS or Lin... |
| [`faff`](bin/faff) | Sleeps for the given number of seconds, showing a progress bar. |
| [`flip`](bin/flip) | Flips input upside down. |
| [`fs`](bin/fs) | Tweak ripgrep to easily search codebases with committed files and f... |
| [`git_authors`](bin/git_authors) | Git script for discovering who wrote the code at the current workin... |
| [`git_jest`](bin/git_jest) | Runs jest tests that have changed within in the latest N commits. |
| [`git_ltr`](bin/git_ltr) | Lists (a-la 'ls -ltr') git controlled source files in current direc... |
| [`git_name_change`](bin/git_name_change) | Clones a repo then changes the name and email address in entire his... |
| [`git_parent`](bin/git_parent) | Finds the direct parent of the current branch in git. |
| [`git_pretty`](bin/git_pretty) | Runs prettier on vue/js/ts files in the most recent N commits. |
| [`git_pretty_log`](bin/git_pretty_log) | Git script for printing beautiful logs. |
| [`git_push_topic`](bin/git_push_topic) | Force updates remote topic branch with local branch. |
| [`git_reauthor`](bin/git_reauthor) | In git, change the author name and/or email of a single commit. |
| [`git_rspec`](bin/git_rspec) | Runs rspec tests that have changed within in the latest N commits. |
| [`git_sync`](bin/git_sync) | Fetch and fast-forward to the latest for origin/master. |
| [`git_tidy`](bin/git_tidy) | Tidies up all the junk this repository. |
| [`git_up`](bin/git_up) | Rebase branch on the latest changes for the remote parent branch. |
| [`git_what`](bin/git_what) | Build a useful git description of the changes in this branch. |
| [`golist`](bin/golist) | Lists all user installed go packages. |
| [`install_odbc`](bin/install_odbc) | Sets up ODBC. |
| [`jsc`](bin/jsc) | Symbolic link to '/System/Library/Frameworks/JavaScriptCore.framewo... |
| [`ks`](bin/ks) | Sometimes spring server gets caddywhompus, this script kills it. |
| [`macosver`](bin/macosver) | Prints current macOS version information. |
| [`nodeula-rasa`](bin/nodeula-rasa) | Gives you a total clean slate in your node project. |
| [`nopw`](bin/nopw) | Enables password-less ssh TO username@remotehost FROM localhost. |
| [`npm-update`](bin/npm-update) | Tries to update package dependencies to latest using ncu, npm, and ... |
| [`prettier`](bin/prettier) | Symbolic link to '/usr/local/bin/prettier' |
| [`root`](bin/root) | Prints the root of the current repository. |
| [`set_wallpaper`](bin/set_wallpaper) | Uses Cocoa classes via PyObjC to set a desktop wallpaper on all scr... |
| [`share`](bin/share) | Easy way to manage temporary web shares. |
| [`shfmt`](bin/shfmt) | Symbolic link to '/usr/local/bin/shfmt' |
| [`show_dircolors`](bin/show_dircolors) | Shows example output based on current dircolors settings. |
| [`slept`](bin/slept) | Get time macOS system last went to sleep. |
| [`smongo`](bin/smongo) | Opens mongo shell to master node. |
| [`uninstall_homebrew`](bin/uninstall_homebrew) | Uninstalls Homebrew. |
| [`usages`](bin/usages) | Prints out documentation and usages for utilities. |
| [`weather`](bin/weather) | Show the current weather directly in your terminal. |
| [`whereami`](bin/whereami) | Prints your current city name using your geoip location. |
| [`woke`](bin/woke) | Get time macOS system last woke from sleep. |
| [`xdie`](bin/xdie) | Kills processes based on their window title. |
| [`xf`](bin/xf) | Extract common file formats. |
| [`yaml2json`](bin/yaml2json) | Converts yaml input to json output. |
| [`youtube2mp3`](bin/youtube2mp3) | Downloads the audio from a youtube video given the URL. |
| [`zoomwatcher`](bin/zoomwatcher) | A service that watches for zoom and turns a blinkstick red if it is... |

# What does `equip all` install?

Glad you asked! `equip all` will go through the following steps one by one. For the steps that
install packages/formulas/casks/whatever, see below for the list of included items.

| Step | Description |
| --- | --- |
| xcode | Ensure that Xcode Command Line Tools are installed |
| dotfiles | Ensure home directory is a git repository for dotfiles |
| java | Ensure that Apple's java for macOS is installed |
| brew | Ensure Homebrew installed, formulas upgraded, and Amphetamine installed |
| cask | Ensure Homebrew Casks are installed |
| ext | Ensure file extension associations are correct |
| zsh | Ensure shell is latest version of zsh from Homebrew |
| env | Update environment configuration and submodules |
| python | Upgrade/Install Anaconda, pip packages, and conda packages |
| node | Ensure Node modules are installed via npm |
| go | Ensure Go packages are installed |
| cargo | Ensure Rust packages are installed via cargo |
| gem | Upgrade/Install gem packages and rubygems-update package |
| atom | Ensure Atom installed via Homebrew Cask and apm packages are upgraded |
| code | Ensure VS Code installed via Homebrew Cask and its packages are installed |
| osx | Override macOS "defaults" settings and configuration |
| dot | Runs steps: dotfiles zsh env |
| apps | Runs steps: xcode java brew cask ext python node go cargo gem atom code |
| most | Runs steps: apps dot (basically everything but the osx step) |
| all | Runs all steps |

Homebrew Formulas: adns, aom, autoconf, automake, avro-c, bash, bat, cairo, 
clang-format, cmake, colordiff, coreutils, csv-fix, diff-so-fancy, docker, 
doxygen, duti, entr, exa, exiftool, expect, faac, fasd, ffmpeg, flac, flake8, 
fontconfig, freetype, frei0r, fribidi, fzf, gd, gdbm, geoip, gettext, 
ghostscript, giflib, gifsicle, git, git-flow, git-lfs, git-review, git-secrets, 
glib, gmp, gnu-sed, gnu-tar, gnupg, gnutls, graphicsmagick, graphite2, 
harfbuzz, hub, icu4c, id3lib, imagemagick@6, isl, jansson, jasper, jbig2dec, 
jez/formulae/pandoc-sidenote, jhead, jo, jpeg, jq, kafkacat, krb5, lame, 
leptonica, libass, libassuan, libbluray, libevent, libffi, libgcrypt, 
libgpg-error, libidn2, libksba, libmpc, libogg, libpng, librdkafka, 
libsamplerate, libserdes, libsndfile, libsoxr, libssh2, libtasn1, libtiff, 
libtool, libunistring, libusb, libusb-compat, libvidstab, libvo-aacenc, 
libvorbis, libvpx, libyaml, little-cms2, lz4, lzlib, lzo, makedepend, mas, 
md5sha1sum, memcached, minio, mpfr, mtr, mysql, ncftp, ncurses, net-snmp, 
nettle, nginx, node, npth, nvm, oniguruma, opencore-amr, openjpeg, openssl, 
opus, ossp-uuid, p11-kit, pandoc, pcre, pcre2, pidof, pinentry, pixman, 
pkg-config, plotutils, pngquant, postgresql, protobuf, pyenv, pyenv-virtualenv, 
pyenv-virtualenvwrapper, python, re2, readline, redis, ripgrep, rlwrap, 
rtmpdump, rubberband, runit, rust, sdl2, shellcheck, shfmt, snappy, speex, 
sqlite, tesseract, theora, tree, unbound, v8, vegeta, vramsteg, watch, wdiff, 
webp, wget, x264, x265, xvid, xz, yajl, yaml-cpp, yarn, youtube-dl, zlib, zsh, 
zstd

Homebrew Casks: 1password, atom, atom-beta, clamxav, dbvisualizer, 
disk-inventory-x, docker, dropbox, fantastical, firefox, flux, font-fira-code, 
font-hack-nerd-font, google-chrome, iexplorer, istumbler, iterm2, java, 
kaleidoscope, lingon-x, mactex, mcgimp, mysqlworkbench, silverlight, skype, 
slack, snes9x, sourcetree, spectacle, spotify, steam, sublime-text, texstudio, 
the-unarchiver, transmission, vagrant, visual-studio-code, vlc, whatsapp, 
xquartz

Atom Packages: atom-notes, auto-update-packages, highlight-selected, 
language-markdown, minimap, minimap-highlight-selected, minimap-selection, 
native-ui, pen-paper-coffee-syntax, sort-lines, trailing-spaces, typewriter

Code Packages: BriteSnow.vscode-toggle-quotes, DavidAnson.vscode-markdownlint, 
GrapeCity.gc-excelviewer, HookyQR.beautify, James-Yu.latex-workshop, 
PascalReitermann93.vscode-yaml-sort, ban.spellright, be5invis.toml, 
bibhasdn.unique-lines, bung87.vscode-gemfile, dbaeumer.vscode-eslint, 
eamodio.gitlens, esbenp.prettier-vscode, exiasr.hadolint, 
foxundermoon.shell-format, freakypie.code-python-isort, golang.Go, 
karunamurti.haml, lehni.vscode-titlebar-less-macos, magicstack.MagicPython, 
mgmcdermott.vscode-language-babel, mike-co.import-sorter, misogi.ruby-rubocop, 
mohsen1.prettify-json, ms-azuretools.vscode-docker, ms-python.python, 
octref.vetur, otoniel-isidoro.vscode-ruby-ctags, rebornix.ruby, 
richie5um2.vscode-sort-json, sianglim.slim, spywhere.guides, 
sysoev.language-stylus, timonwong.shellcheck, vscode-icons-team.vscode-icons, 
waderyan.gitblame, wingrunr21.vscode-ruby

Pip Packages: git-sweep3k, glances, httpie, inflection, patch, 
python-json-logger, pyyaml, termcolor

Conda Packages: flake8, ipython, isort, jedi, nose, pep8, pygments, pylint, 
pytest, python-dateutil, pytz, readline, requests, setuptools, six

Gem Packages: jekyll, lolcat, rake, rdoc, rubocop

Node Modules: @ibm/plex, JSON, all-contributors-cli, coffeelint, coffeescript, 
cson, decaffeinate, dockerlint, eslint, external-ip, generator-code, 
generator-generator, geoip-lite, js-beautify, json-stable-stringify, moment, 
nesh, npm-check-updates, npm-remote-ls, npm-why, prettier, raml2html, standard, 
tmpin, typescript, yo

Go Packages: github.com/BurntSushi/toml, github.com/acroca/go-symbols, 
github.com/cweill/gotests, github.com/davidrjenni/reftools, 
github.com/fatih/gomodifytags, github.com/golang/lint, 
github.com/haya14busa/goplay, github.com/josharian/impl, 
github.com/karrick/godirwalk, github.com/mdempsky/gocode, 
github.com/ramya-rao-a/go-outline, github.com/rogpeppe/godef, 
github.com/uudashr/gopkgs, golang.org/x/crypto, golang.org/x/lint, 
golang.org/x/net, golang.org/x/sync, golang.org/x/sys, golang.org/x/text, 
golang.org/x/tools, honnef.co/go/tools

Cargo Packages: cargo-update, loc

# License

```
Inconsolata font Created by Raph Levien using his own tools and FontForge.
Copyright 2006 Raph Levien. Released under the SIL Open Font License.


The MIT License (MIT)

Copyright (c) 2020, lexicalunit@lexicalunit.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

