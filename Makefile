.PHONY: all install copy tmux alacritty nvim starship fonts help

DOTS_DIR := $(shell pwd)
CONFIG_DIR := $(HOME)/.config

all: install copy fonts

install: nvim tmux alacritty starship

nvim:
	@echo "→ Installing neovim..."
	sudo add-apt-repository -y ppa:neovim-ppa/unstable
	sudo apt update
	sudo apt install -y neovim

tmux:
	@echo "→ Installing tmux..."
	sudo apt install -y tmux

alacritty:
	@echo "→ Installing alacritty..."
	sudo add-apt-repository -y ppa:aslatter/ppa
	sudo apt update
	sudo apt install -y alacritty

starship:
	@echo "→ Installing starship..."
	wget -qO- https://starship.rs/install.sh | sh -s -- --yes

copy:
	@echo "→ Copying configuration files..."
	mkdir -p $(CONFIG_DIR)/tmux
	cp -f $(DOTS_DIR)/config/tmux/tmux.conf $(CONFIG_DIR)/tmux/tmux.conf
	mkdir -p $(CONFIG_DIR)/alacritty
	cp -f $(DOTS_DIR)/config/alacritty/alacritty.toml $(CONFIG_DIR)/alacritty/alacritty.toml
	cp -rf $(DOTS_DIR)/config/alacritty/themes $(CONFIG_DIR)/alacritty/themes
	cp -f $(DOTS_DIR)/config/starship/starship.toml $(CONFIG_DIR)/starship.toml
	cp -f $(DOTS_DIR)/config/bash/.bashrc $(HOME)/.bashrc
	mkdir -p $(CONFIG_DIR)/git
	cp -f $(DOTS_DIR)/config/git/config $(CONFIG_DIR)/git/config
	@echo "✓ Done"

fonts:
	@echo "→ Installing FiraCode Nerd Font..."
	wget -O fira_code.tar.xz https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz
	mkdir -p fira_code
	tar -xf fira_code.tar.xz -C fira_code
	mkdir -p $(HOME)/.local/share/fonts
	cp fira_code/*.ttf $(HOME)/.local/share/fonts/
	fc-cache -fv
	rm -rf fira_code fira_code.tar.xz

help:
	@echo "Targets:"
	@echo "  make          - install everything + copy configs"
	@echo "  make install  - install all tools"
	@echo "  make copy     - copy configuration files"
	@echo "  make fonts    - install FiraCode Nerd Font"
	@echo "  make nvim     - install neovim"
	@echo "  make tmux     - install tmux only"
	@echo "  make alacritty - install alacritty only"
	@echo "  make starship - install starship only"
