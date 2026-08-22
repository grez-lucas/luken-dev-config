# My Dev Config Files 🚀

These are dot files for my development setup.

# Terminal Setup

Some of these CLI tools are needed for certain plugins to work.

- [fzf](https://github.com/junegunn/fzf.git)
- [fd](https://github.com/sharkdp/fd)
- [bat](https://github.com/sharkdp/bat)
- [delta](https://github.com/dandavison/delta)
- [tldr](https://github.com/tldr-pages/tldr)
- [stow]()

### Post Cloning

After cloning the repo, run:
```bash
stow --adopt .
```

To make `stow` create necessary symlinks.

### Relevant files

- [.zshrc](.zshrc) - Zsh Shell Configuration

# Tmux Setup

### Setup requires

- [Installing ZSH](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH) - For Oh-My-ZSH to work
- [Installing Oh-My-Zsh](https://github.com/ohmyzsh/ohmyzsh)
- Installing ZSH Plugins
    - [ZSH Syntax Highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
    - [ZSH Completions](https://github.com/zsh-users/zsh-completions)
    - [ZSH Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
    - [OMZ Autoupdate](https://github.com/tamcore/autoupdate-oh-my-zsh-plugins)
- Leaving the [.zshrc](.zshrc) file in your root directory

### Relevant files

- [.config/tmux/tmux.conf](.config/tmux/tmux.conf) - Tmux configuration

TPM and its plugins are gitignored. Bootstrap them on a new machine with:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```
then press <kbd>prefix</kbd> + <kbd>I</kbd> inside tmux to install the rest.


# Neovim Setup

This setup uses lazy.nvim.

_If you clone the repo into your machine and use the config by copying .config/nvim to your home folder, wait for the plugins, language servers and parsers to install with lazy.nvim, Mason and nvim-treesitter.
If you are opening a lua file or another file I have language servers configured for, like html, css or javascript/typescript, you might also get an error saying that the server failed to start. This is because Mason hasn't installed it yet. Press enter to continue, Mason will automatically install it._

### Relevant Files

- [.config/nvim](.config/nvim) - LazyVim configuration

### Setup requires

- [Neovim](https://neovim.io/) (Version 0.10 or later)
- [Nerd Font](https://www.nerdfonts.com/) - I use JetBrainsMono Nerd Font
- [Ripgrep](https://github.com/BurntSushi/ripgrep) - For Telescope Fuzzy Finder
