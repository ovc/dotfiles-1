# Dotfiles

Most of my personal dotfiles can be found in this branch. I use dfm (dot file manager) to install and managed the dotfiles. See [ justone/dotfiles ](https://github.com/justone/dotfiles) for details on how to use it.

# Highlights

 * Check out my vim configurations -- they are super cool!
 * [bin/](bin/) -- many handy and time saving scripts.

# Installation

```bash
$ git clone git://github.com/erikw/dotfiles.git ~/.dotfiles
$ cd !$
$ git submodule init
$ git submodule update
$ dfm install
```

Switch to a local branch for secret changes:

```bash
$ git checkout -b local
```

Passwords and other secretes are censored. To find these and substitue them for the real thing, do

```bash
$ grep -nr GIT-CENSORED .
```


## Vim

```bash
$ vim -c BundleInstall
```

## Tmux

Install: 

 * https://github.com/powerline/powerline
 * urlview(1)
 * https://github.com/tmux-plugins/tpm Then reload tmux.conf and press `prefix-I`.

## ZSH/Bash

Install for both:
 * https://github.com/seebi/dircolors-solarized
 * https://www.gnu.org/software/src-highlite/source-highlight.html

Install for ZSH:
 * https://github.com/flavio/jump
