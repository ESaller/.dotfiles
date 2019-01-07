####################
# VARIABLES/SETUP
####################

# The shell
SHELL = /bin/bash

# Where is this repositorty
DOTFILES_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

# Am I OSX or LINUX?
OS := $(shell bin/is-supported bin/is-macos macos linux)

# Put all utilities at the front of the PATH
PATH := $(DOTFILES_DIR)/bin:$(PATH)

# Locations for configs

# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME := $(HOME)/.config


export DEFAULT_STOW_DIR := $(DOTFILES_DIR)/resources/

####################
# TEST
####################

.PHONY: test


####################
# OS
####################

all: $(OS)

macos: sudo core-macos packages-macos link

linux: core-linux link


####################
# Core
####################

core-macos: brew zsh git

core-linux:
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -f


####################
# STOW
####################

stow-macos: brew
	is-executable stow || brew install stow

stow-linux: core-linux
	is-executable stow || apt-get -y install stow

sudo:
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


link: stow-$(OS)
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p $(XDG_CONFIG_HOME)
	stow -t $(HOME) runcom
	stow -t $(XDG_CONFIG_HOME) config

unlink: stow-$(OS)
	stow --delete -t $(HOME) runcom
	stow --delete -t $(XDG_CONFIG_HOME) config
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | ruby

zsh: ZSH=/usr/local/bin/zsh
zsh: SHELLS=/private/etc/shells
zsh: brew
	if ! grep -q $(ZSH) $(SHELLS); then brew install zsh && sudo append $(ZSH) $(SHELLS) && chsh -s $(ZSH); fi

git: brew
	brew install git git-extras


####################
# PACKAGE MANAGER
####################

packages-macos: brew-packages brew-cask


##########
# BREW
##########

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile

brew-cask: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile

test:
	bats test/*.bats
