DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHELL := /usr/bin/env zsh
PATH := $(DOTFILES_DIR)/bin:$(PATH)

.PHONY: all

all: sys brew-all link dock zsh xcode-clt

brew:
	depends-on brew || curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' | bash

brew-all: brew-pkgs brew-apps

brew-pkgs: brew
	brew bundle install --file="$(DOTFILES_DIR)/install/Brewfile"

brew-apps: brew
	brew bundle install --file="$(DOTFILES_DIR)/install/Caskfile"

ensure-stow: brew
	depends-on stow || brew install stow

link: ensure-stow
	./config/dotsetup --verbose --all

unlink: ensure-stow
	./config/dotsetup --verbose --all --uninstall

sys:
	./system/settings

dockutil: brew
	depends-on dockutil || brew install dockutil

dock: dockutil
	./system/dock --clear

xcode-clt:
	xcode-select --install || true

zsh:
	./system/zsh --all

pull:
	git -c protocol.file.allow=always submodule update --remote --checkout --force
