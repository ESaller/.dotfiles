```
      ██            ██     ████ ██  ██
     ░██           ░██    ░██░ ░░  ░██
     ░██  ██████  ██████ ██████ ██ ░██  █████   ██████
  ██████ ██░░░░██░░░██░ ░░░██░ ░██ ░██ ██░░░██ ██░░░░
 ██░░░██░██   ░██  ░██    ░██  ░██ ░██░███████░░█████
░██  ░██░██   ░██  ░██    ░██  ░██ ░██░██░░░░  ░░░░░██
░░██████░░██████   ░░██   ░██  ░██ ███░░██████ ██████
 ░░░░░░  ░░░░░░     ░░    ░░   ░░ ░░░  ░░░░░░ ░░░░░░

  ▓▓▓▓▓▓▓▓▓▓
 ░▓ about  ▓ setup and configuration for osx and linux based systems
 ░▓ author ▓ esaller <github@saller.io>
 ░▓ code   ▓ https://github.com/ESaller/dotfiles
 ░▓▓▓▓▓▓▓▓▓▓

```
## Table of Contents
 - [Introduction](#Introcution)
 - [Overview](#Overview)
 - [How it Works](#How-it-Works)
 - [tl;dr](#tldr)


# Introduction
Hello and welcome to my dotfiles repository. Over the years and with the inspiration of many other people I have created a single place for all my configuration files togther with the tooling to manage/install them quickly.


# Overview
The core components for the tooling are [make](https://www.gnu.org/software/make/) and [stow](https://www.gnu.org/software/make/)


## Make
GNU Make is a tool which controls the generation of executables and other non-source files of a program from the program's source files.

Make gets its knowledge of how to build your program from a file called the makefile, which lists each of the non-source files and how to compute it from other files. When you write a program, you should write a makefile for it, so that it is possible to use Make to build and install the program.

This provides the scaffolding for all the steps needed to install my configuration on a machine. Straightforwrd and battle tested


## Stow

GNU Stow is a symlink farm manager which takes distinct packages of software and/or data located in separate directories on the filesystem, and makes them appear to be installed in the same place.

This allows us to link the confiuration from inside this repository to other places like the home directory, where most configuration files are usally located. 


# How it works

```
.
├── Makefile
├── README.md
├── bin
│   ├── is-executable
│   ├── is-macos
│   └── is-supported
└── resources
    ├── home
    │   ├── chunkwm
    │   ├── kitty
    │   ├── skhd
    │   ├── tmux
    │   ├── vim
    │   └── zsh
    └── lists
        └── brew
```

The main interaction point with this repository is the Makefile that comes with it.

With this command you can list the functionality

`make help`

## Directory descriptions

`/bin` : Provides small scripts that are used inside the Makefile

`/resources` : All configuration files are lcoated in here

`/resources/home` : Configuration files that should be placed in the users home directory are seprated and placed in destinct directories named after the tool (e.g. the file `.vimrc` inside the folder `vim` will pe linked to `~/.vimrc`)

`/resoruces/lists` : List of tools and software that should be installed


# tl;dr
Navigate to your home directory

`cd ~`

Clone the repository:

`git clone https://github.com/ESaller/dotfiles`

Enter the dotfiles directory

`cd dotfiles`

Install everything

`make all`



# Shoutouts

Interesting links to people/projects/software

## People
- [xero](https://github.com/xero/dotfiles) interesting dotfiles repsoitory

## Software
- [brew](https://brew.sh/) The missing package manager for macOS (or Linux)
- [chunkwm](https://github.com/koekeishiya/chunkwm) Tiling window manager for macOS based on plugin architecture 
- [make](https://www.gnu.org/software/make/) Make enables the end user to build and install your package without knowing the details of how that is done 
- [stow](https://www.gnu.org/software/stow/) Stow is a symlink farm manager
- [figlet](http://www.figlet.org/) FIGlet is a program for making large letters out of ordinary text 
- [fzf](https://github.com/junegunn/fzf) fzf is a general-purpose command-line fuzzy finder
- [skhd](https://github.com/koekeishiya/skhd) Simple hotkey daemon for macOS, specifically for chunkwm
- [vim ](https://www.vim.org/) My terminal editor of choice
- [zsh](https://www.zsh.org/) My shell of choice


## Workflows
- [cookiecutter-data-science](https://github.com/drivendata/cookiecutter-data-science) good information on how to organizse projects