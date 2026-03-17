.PHONY: all install link deps tmux alacritty nvim starship fonts help

DOTS_DIR := $(shell pwd)
CONFIG_DIR := $(HOME)/.config

all: deps install link fonts

deps:
	@echo "→ Installing dependencies..."
	sudo apt install -y curl unzip

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
	sudo snap install alacritty --classic

starship:
	@echo "→ Installing starship..."
	curl -sS https://starship.rs/install.sh | sh -s -- --yes

link:
	@echo "→ Linking configs..."
	mkdir -p $(CONFIG_DIR)/tmux
	ln -sf $(DOTS_DIR)/config/tmux/tmux.conf $(CONFIG_DIR)/tmux/tmux.conf
	mkdir -p $(CONFIG_DIR)/alacritty
	ln -sf $(DOTS_DIR)/config/alacritty/alacritty.toml $(CONFIG_DIR)/alacritty/alacritty.toml
	ln -sf $(DOTS_DIR)/config/alacritty/themes $(CONFIG_DIR)/alacritty/themes
	ln -sf $(DOTS_DIR)/config/starship/starship.toml $(CONFIG_DIR)/starship.toml
	ln -sf $(DOTS_DIR)/config/bash/.bashrc $(HOME)/.bashrc
	mkdir -p $(CONFIG_DIR)/git
	ln -sf $(DOTS_DIR)/config/git/config $(CONFIG_DIR)/git/config
	@echo "✓ Done"

fonts:
	@echo "→ Installing FiraCode Nerd Font..."
	mkdir -p /tmp/firacode-nf
	curl -Lo /tmp/firacode-nf/FiraCode.zip \
		https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
	unzip -o /tmp/firacode-nf/FiraCode.zip -d /tmp/firacode-nf
	mkdir -p $(HOME)/.local/share/fonts
	cp /tmp/firacode-nf/*.ttf $(HOME)/.local/share/fonts/
	fc-cache -fv
	rm -rf /tmp/firacode-nf

help:
	@echo "Targets:"
	@echo "  make          - install everything + link configs"
	@echo "  make install  - install all tools"
	@echo "  make link     - symlink configs to home"
	@echo "  make fonts    - install FiraCode Nerd Font"
	@echo "  make nvim     - install neovim"
	@echo "  make tmux     - install tmux only"
	@echo "  make alacritty - install alacritty only"
	@echo "  make starship - install starship only"
