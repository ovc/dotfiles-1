# Dotfiles

Most of my personal dotfiles can be found in this branch. I use dfm (dot file manager) to install and managed the dotfiles. See [ justone/dotfiles ](https://github.com/justone/dotfiles) for details on how to use it.

# Installation

```bash
$ git clone git://github.com/erikw/dotfiles.git ~/.dotfiles
$ cd !$
$ git submodule init
$ git submodule update
$ dfm install
$ vim -c BundleInstall
```

Passwords and other secretes are censored. To find these and substitue them for the realthing, do

```bash
$ grep -nr GIT-CENSORED .
```

# Highlights

 * Check out my vim configurations -- they are super cool!
 * [bin/](bin/) -- many handy and time saving scripts.
