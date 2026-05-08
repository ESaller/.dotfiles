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
 ░▓ about  ▓ setup and configuration for neovim and terminal environment
 ░▓ author ▓ esaller
 ░▓ code   ▓ https://github.com/ESaller/dotfiles
 ░▓▓▓▓▓▓▓▓▓▓

```
# Introduction
Hello and welcome to my dotfiles repository. Over the years and with the inspiration of many other people I have created a single place for my main configuration files.


# How to use

## macOS

1. Install [Homebrew](https://brew.sh)
2. Install `git` and `stow`: `brew install git stow`
3. Clone the repository into your `$HOME` directory
4. Install packages: `brew bundle --file=brew/Brewfile`
5. Symlink configs: `./workspace.install`
6. Upgrade packages later: `brew/upgrade.sh`

## Linux (Debian/Ubuntu)

1. Install `git` and `stow`: `sudo apt-get install git stow`
2. Clone the repository into your `$HOME` directory
3. Install packages: `apt/install.sh`
4. Symlink configs: `./workspace.install`
5. Upgrade packages later: `apt/upgrade.sh`
