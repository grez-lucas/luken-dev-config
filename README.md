# My Dev Config Files 🚀

These are dot files for my development setup.

# Terminal Setup

Some of these CLI tools are needed for certain plugins to work.

- [fzf](https://github.com/junegunn/fzf.git)
- [fd](https://github.com/sharkdp/fd)
- [bat](https://github.com/sharkdp/bat)
- [delta](https://github.com/dandavison/delta)
- [tldr](https://github.com/tldr-pages/tldr)

### Relevant files

- [.zshrc](.zshrc) - Zsh Shell Configuration

# Tmux Setup

### Setup requires

- [Installing ZSH](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH) - For Oh-My-ZSH to work
- [Installing Oh-My-Zsh](https://github.com/ohmyzsh/ohmyzsh)
- Leaving the [.zshrc](.zshrc) file in your root directory

### Relevant files

- [tmux.conf](tmux.conf) - Tmux Configuration File


# Neovim Setup

This setup uses lazy.nvim.

_If you clone the repo into your machine and use the config by copying .config/nvim to your home folder, wait for the plugins, language servers and parsers to install with lazy.nvim, Mason and nvim-treesitter.
If you are opening a lua file or another file I have language servers configured for, like html, css or javascript/typescript, you might also get an error saying that the server failed to start. This is because Mason hasn't installed it yet. Press enter to continue, Mason will automatically install it._

### Relevant Files

- [/nvim/lua/luken](/nvim/lua/luken) - Config files for Neovim

### Setup requires

- [Neovim](https://neovim.io/) (Version 0.9 or Later)
- [Nerd Font](https://www.nerdfonts.com/) - I use Meslo Nerd Font
- [Ripgrep](https://github.com/BurntSushi/ripgrep) - For Telescope Fuzzy Finder

