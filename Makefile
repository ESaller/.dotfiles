#################################################################################
# VARIABLES/SETUP
#################################################################################

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


#################################################################################
# TEST
#################################################################################

.PHONY: test


#################################################################################
# OS
#################################################################################

## Install everything for your OS (supported: macos, linux)
all: $(OS)

## Install and link dotfiles (macos)
macos: sudo core-macos packages-macos link

## Install land link dotfiles (linux)
linux: core-linux linux-fasd link 


#################################################################################
# Core
#################################################################################

## Install macos core (brew zsh git)
core-macos: brew zsh-macos git

## Install, update and upgrade via apt-get
core-linux: zsh-linux linux-packages
	apt-get update
	apt-get upgrade -y

## Install brew
brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | ruby

#TODO: Check shells file an chsh zsh

zsh-macos: brew
	#if ! grep -q $(ZSH) $(SHELLS); then brew install zsh && sudo append $(ZSH) $(SHELLS) && chsh -s $(ZSH); fi
	is-executable zsh || brew install zsh
zsh-linux:
	#if ! grep -q $(ZSH) $(SHELLS); then apt-get install -y zsh && sudo append $(ZSH) $(SHELLS) && chsh -s $(ZSH); fi
	is-executable zsh || apt-get update && apt-get install -y zsh


## Brew install git
git: brew
	brew install git git-extras


#################################################################################
# STOW
#################################################################################

## Install stow on macos
stow-macos: brew
	is-executable stow || brew install stow

## Install stow on linux
stow-linux: core-linux
	is-executable stow || apt-get -y install stow

## Sudo
sudo:
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

## Link all dotfiles
link: stow-$(OS)
	#mkdir -p $(XDG_CONFIG_HOME)
	#stow -t $(XDG_CONFIG_HOME) config
	for DIR in $(DEFAULT_STOW_HOME_DIRS)/*;do echo "Now trying to link: $$(\basename $$DIR)" ; stow -t $(HOME) -d $(DEFAULT_STOW_HOME_DIRS) $$(\basename $$DIR) --verbose; done

## Unlink all dotfiles
unlink: stow-$(OS)
	for DIR in $(DEFAULT_STOW_HOME_DIRS)/*;do echo "Now trying to unlink: $$(\basename $$DIR)" ; stow --delete -t $(HOME) -d $(DEFAULT_STOW_HOME_DIRS) $$(\basename $$DIR) --verbose; done


#################################################################################
# PACKAGE MANAGER
#################################################################################

## Install all my brew packages and brew casks
packages-macos: brew-packages brew-cask


##########
# BREW
##########

## Install all brew packages
brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)resources/lists/brew/Brewfile

## Install all brew casks
brew-cask: brew
	brew bundle --file=$(DOTFILES_DIR)resources/lists/brew/Caskfile


##########
# APT-GET
##########

linux-packages:
	xargs sudo apt-get install -y <$(DOTFILES_DIR)resources/lists/apt-get/packages.txt


##########
# DIY
##########

linux-fasd:
	git clone https://github.com/clvv/fasd.git && cd fasd && make install

linux-zplug:
	git clone https://github.com/zplug/zplug

#################################################################################
# Try inside docker
#################################################################################
## Try insinde docker NOT WORKING
tryme: tryme-build tryme-run

## Try insinde docker NOT WORKING
tryme-build:
	docker build --no-cache --file $(DOTFILES_DIR)resources/docker/tryme/Dockerfile --tag esaller_dotfiles_tryme:latest $(DOTFILES_DIR)

## Try insinde docker NOT WORKING
tryme-run:
	docker run --rm -i -t esaller_dotfiles_tryme zsh


#################################################################################
# Self Documenting Commands
#################################################################################

.DEFAULT_GOAL := help

# Inspired by <http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>
# sed script explained:
# /^##/:
# 	* save line in hold space
# 	* purge line
# 	* Loop:
# 		* append newline + line to hold space
# 		* go to next line
# 		* if line starts with doc comment, strip comment character off and loop
# 	* remove target prerequisites
# 	* append hold space (+ newline) to line
# 	* replace newline plus comments by `---`
# 	* print line
# Separate expressions are necessary because labels cannot be delimited by
# semicolon; see <http://stackoverflow.com/a/11799865/1968>
.PHONY: help
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) = Darwin && echo '--no-init --raw-control-chars')