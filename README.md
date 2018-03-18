# dotfiles

Configuration files

## Overview

Inspired by the [bare repo](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/) approach.

The key components are:

    # Bare repository
    git clone --bare git@github.com:nullus/dotfiles.git $HOME/.dotfiles
    
    # Alias to run git configuration against bare repository
    alias dotfile="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

    # You will also want
    dotfile config status.showUntrackedFiles no

    # Checkout an existing dotfile repo
    dotfile checkout
