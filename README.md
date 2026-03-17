
## What's included

- **tmux** — terminal multiplexer
- **alacritty** — terminal emulator
- **neovim** — text editor
- **starship** — shell prompt
- **FiraCode Nerd Font** — font

## Install

```bash
git clone https://github.com/MrJustice/dots.git ~/dots
cd ~/dots
make
```

This will install all tools and symlink configs to their proper locations.

## Individual targets

```bash
make install   # install all tools (no symlinks)
make link      # symlink configs only
make nvim      # install neovim only
make tmux      # install tmux only
make alacritty # install alacritty only
make starship  # install starship only
make fonts     # install FiraCode Nerd Font only
```
