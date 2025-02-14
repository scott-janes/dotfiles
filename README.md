# Dodgy dot files

My dotfiles for:

- aerospace
- borders
- nvim
- sketchybar
- zellij
- zsh

These are my personal dotfiles and they are in a terrible state and need tidying up at some point. The folders that are in desperate need to fix are, sketchybar and zsh they both need re writing but they kind of work but the zsh is very much built for my WSL2 windows setup

So use at your own risk

## Setup

These are just the dotfiles so everything will need installing and may require some manual setup steps

But clone this to `~`and cd into the dotfiles folder and run `make install` that will add the relevant folders into the `.config`

## Other

I also have a folder called other that contains scripts to add to the bin as a symlink to make things easier

### zellij-sessionizer

This is set as `zsesh` so I can run it from anywhere and choose one of my git repos to open in zellij either with an existing session or create a new one

`ln -s ~/dotfiles/other/zellij-sessionizer.sh /opt/homebrew/bin/zsesh`

### zellij-sweeper

This is set as `zsweep` so it can be run from anywhere and can be used to clean up zellij sessions

`ln -s ~/dotfiles/other/zellij-sweeper.sh /opt/homebrew/bin/zsweep`
