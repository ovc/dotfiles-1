# Dotfiles

Most of my personal dotfiles can be found in this branch. I use dfm (dot file manager) to install and managed the dotfiles. See [justone/dotfiles](https://github.com/justone/dotfiles) for details on how to use it.

# Highlights

 * Check out my vim configurations -- they are super cool!
 * [bin/](bin/) -- many handy and time saving scripts.

# Installation

```bash
$ git clone git@github.com:erikw/dotfiles.git ~/.dotfiles
$ cd !$
$ git submodule init
$ git submodule update
$ bin/dfm install
```

Switch to a local branch for secret changes:

```bash
$ git checkout -b local
```

Passwords and other secretes are censored. To find these and substitue them for the real thing, do

```bash
$ grep -nr GIT-CENSORED .
```

## General

* [altercation/solarized](https://github.com/altercation/solarized)

## Vim

```bash
$ vim -c BundleInstall
```

### Compile command-t
```bash
$ cd ~/.vim/bundle/command-t/ruby/command-t
$ ruby extconf.rb
$ make
````

### jedi-vim
```bash
$ cd ~/.vim/bundle/jedi-vim/jedi
$ git submodule update --init
````

### rope
```bash
$ pip3 install --user ropevim
$ cat >> ~/.zshrc
export PYTHONPATH="$PYTHONPATH:$HOME/Library/Python/3.5/lib/python/site-packages"
^D
````

### isort
```bash
$ pip3 install --user isort
````

## Tmux

Install: 

 * [powerline](https://github.com/powerline/powerline)
 * urlview(1)
 * [tpm](https://github.com/tmux-plugins/tpm) Then reload tmux.conf and press `prefix-I`.
 * [seebi/tmux-colors-solarized](https://github.com/seebi/tmux-colors-solarized)
 * `brew install reattach-to-user-namespace` if on OSX

## ZSH/Bash

Install for both:
 * [seebi/dircolors-solarized](https://github.com/seebi/dircolors-solarized)
 * [GNU source-highlight](https://www.gnu.org/software/src-highlite/source-highlight.html)
 * [jrunning/source-highlight-solarized](https://github.com/jrunning/source-highlight-solarized)
 * [flavio/jump](https://github.com/flavio/jump)



## Xcode
* [Xvim](http://xvim.org/) Vim keybindings.
* [stackia/solarized-xcode](https://github.com/stackia/solarized-xcode) for dark & light themes.
* [ArtSabintsev/Solarized-Dark-for-Xcode](https://github.com/ArtSabintsev/Solarized-Dark-for-Xcode) for a (better?) dark theme.

