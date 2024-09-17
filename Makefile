DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHELL := /usr/bin/env zsh
PATH := $(DOTFILES_DIR)/bin:$(PATH)

.PHONY: all

all: pkg link

brew:
	depends-on brew || curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' | bash

pkg: brew-pkg

brew-pkg: brew
	brew bundle install --file="$(DOTFILES_DIR)/config/home/.brewfile"

ensure-stow: brew
	depends-on stow || brew install stow

link: ensure-stow
	./config/dotsetup -vd

unlink: ensure-stow
	./config/dotsetup -vd --uninstall
