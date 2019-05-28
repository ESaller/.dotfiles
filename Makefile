####################
# VARIABLES/SETUP
####################

# The shell
SHELL = /bin/bash

# Where is this directory
DOTFILES_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

# Am I MACOS or LINUX?
OS := $(shell bin/is-supported bin/is-macos macos linux)

# Put all utilities at the front of the PATH
PATH := $(DOTFILES_DIR)/bin:$(PATH)

# Locations for configs

# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME := $(HOME)/.config

export DEFAULT_STOW_HOME_DIRS := $(DOTFILES_DIR)resources/home


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
	#mkdir -p $(XDG_CONFIG_HOME)
	#stow -t $(XDG_CONFIG_HOME) config
	for DIR in $(DEFAULT_STOW_HOME_DIRS)/*;do echo "Now trying to link: $$(\basename $$DIR)" ; stow -t $(HOME) -d $(DEFAULT_STOW_HOME_DIRS) $$(\basename $$DIR) --verbose; done

unlink: stow-$(OS)
	for DIR in $(DEFAULT_STOW_HOME_DIRS)/*;do echo "Now trying to unlink: $$(\basename $$DIR)" ; stow --delete -t $(HOME) -d $(DEFAULT_STOW_HOME_DIRS) $$(\basename $$DIR) --verbose; done

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
	brew bundle --file=$(DOTFILES_DIR)install/Brewfile

brew-cask: brew
	brew bundle --file=$(DOTFILES_DIR)install/Caskfile

test:
	bats test/*.bats
