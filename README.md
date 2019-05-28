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
## table of contents
 - [Introduction](#Introcution)
 - [How it Works](#How-it-Works)
 - [tl;dr](#tldr)
 - [license](#license)


# Introduction
Hello and welcome to my dotfiles repository. Over the years and with the inspiration of many other people I have created a single place for all my configuration files togther with the tooling to manage/install them quickly


# Installing
The core components for the tooling are [make](https://www.gnu.org/software/make/) and [stow](https://www.gnu.org/software/make/)


## Make
GNU Make is a tool which controls the generation of executables and other non-source files of a program from the program's source files.

Make gets its knowledge of how to build your program from a file called the makefile, which lists each of the non-source files and how to compute it from other files. When you write a program, you should write a makefile for it, so that it is possible to use Make to build and install the program.

This provides the scaffolding for all the steps needed to install my configuration on a machine. Straightforwrd and battle tested


## Stow

GNU Stow is a symlink farm manager which takes distinct packages of software and/or data located in separate directories on the filesystem, and makes them appear to be installed in the same place.

This allows us to link the confiuration from inside this repository to other places like the home directory, where most configuration files are usally located. 


# How it works
TODO


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

## People
Other interesting dotfiles directories:
- [xero](https://github.com/xero/dotfiles) interesting dotfiles repsoitory

## Software
- [make](https://www.gnu.org/software/make/) Make enables the end user to build and install your package without knowing the details of how that is done 
- [stow](https://www.gnu.org/software/stow/) Stow is a symlink farm manager
- [figlet](http://www.figlet.org/) FIGlet is a program for making large letters out of ordinary text 
- [brew](https://brew.sh/) The missing package manager for macOS (or Linux)

## Workflows
Generall interesting repositories:
- [cookiecutter-data-science](https://github.com/drivendata/cookiecutter-data-science) good information on how to organizse projects

# License

