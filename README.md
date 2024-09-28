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

## Keybindings

#### Window Mangement

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>Q</kbd> | quit active/focused window
| <kbd>Alt</kbd> + <kbd>F4</kbd> | kill window using cursor
| <kbd>Super</kbd> + <kbd>W</kbd> | toggle window on focus to float
| <kbd>Alt</kbd> + <kbd>Enter</kbd> | toggle window on focus to fullscreen
| <kbd>Super</kbd> + <kbd>RightClick</kbd> | resize the window
| <kbd>Super</kbd> + <kbd>LeftClick</kbd> | change the window position
| <kbd>Alt</kbd> + <kbd>W</kbd><kbd>A</kbd><kbd>S</kbd><kbd>D</kbd>| switch the focus around active windows
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>W</kbd><kbd>A</kbd><kbd>S</kbd><kbd>D</kbd>| move/switch windows around active workspace
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>←</kbd><kbd>→</kbd><kbd>↑</kbd><kbd>↓</kbd>| resize windows (hold)
| <kbd>Super</kbd> + <kbd>J</kbd> | toggle dwindle

#### Application Shortcuts

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>T</kbd> | launch kitty terminal
| <kbd>Super</kbd> + <kbd>E</kbd> | launch dolphin file explorer
| <kbd>Super</kbd> + <kbd>F</kbd> | launch firefox
| <kbd>Super</kbd> + <kbd>D</kbd> | launch vencord (replace it with normal discord if u want)

#### Widgets

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>Tab</kbd> | toggle sidebar
| <kbd>Super</kbd> + <kbd>A</kbd> | toggle app launcher mode
| <kbd>Super</kbd> + <kbd>C</kbd> | toggle command launcher mode

#### Print Screen

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>P</kbd> | drag to select area or click on a window to print
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>P</kbd> | print current screen
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>P</kbd> | print current screen (frozen)

#### Workspaces

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>MouseScroll</kbd> | cycle through workspaces
| <kbd>Super</kbd> + <kbd>[0-5]</kbd> | switch to workspace [0-5]
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>[0-5]</kbd> | move active window to workspace [0-5]
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>[0-5]</kbd> | move active window to workspace [0-5] (silently)

#### Special Workspace

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>S</kbd> | move window to special workspace
| <kbd>Super</kbd> + <kbd>S</kbd> | toogle to special workspace

#### Others
| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>L</kbd> | lock screen

<br>

## Command Mode Commands
| Command | Description |
| :--  | :-- |
| <kbd>shutdown</kbd>| shudown pc
| <kbd>restart</kbd>| restart pc
| <kbd>suspend</kbd>| suspend & lock pc
| <kbd>logout</kbd>| logout out hyprland session
| <kbd>notif-clear</kbd>| clear notifications
| <kbd>change-wallpaper</kbd>| open wallpapers menu
