DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHELL := /usr/bin/env zsh
PATH := $(DOTFILES_DIR)/bin:$(PATH)

.PHONY: all

all: sys pkg link dock

brew:
	depends-on brew || curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' | bash

pkg: brew-pkg brew-apps

brew-pkg: brew
	brew bundle install --file="$(DOTFILES_DIR)/install/Brewfile"

brew-apps: brew
	brew bundle install --file="$(DOTFILES_DIR)/install/Caskfile"

ensure-stow: brew
	depends-on stow || brew install stow

link: ensure-stow
	./config/dotsetup -vd

unlink: ensure-stow
	./config/dotsetup -vd --uninstall

sys:
	./system/settings

dock:
	./system/dock -c
