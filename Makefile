DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHELL := /usr/bin/env zsh
PATH := $(DOTFILES_DIR)/bin:$(PATH)

.PHONY: update

install: sys brew-all link dock zsh xcode-clt
update: sys brew-all link dock

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
	mkdir -p ~/.config/tmux/plugins/catppuccin
	git clone https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux || true
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"

pull:
	git -c protocol.file.allow=always submodule update --remote --checkout --force
