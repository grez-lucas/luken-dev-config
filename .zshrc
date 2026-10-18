# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autoupdate ssh-agent zsh-autosuggestions zsh-completions zsh-syntax-highlighting asdf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias vim="~/nvim.appimage"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias k=kubectl
alias kubectl=kubecolor
alias bat=batcat

if command -v kubectl >/dev/null; then
  # Cache location for kubectl completions
  KUBE_COMP="${XDG_CACHE_HOME:-$HOME/.cache}/kubectl_completion.zsh"
  mkdir -p "${KUBE_COMP:h}"

  # Generate completions if missing or kubectl binary changed
  if [[ ! -f $KUBE_COMP || $(command -v kubectl) -nt $KUBE_COMP ]]; then
    kubectl completion zsh >| "$KUBE_COMP"
  fi

  # Load completions
  source "$KUBE_COMP"

  # Map kubecolor's completion to kubectl (must be done after completions are loaded)
  compdef kubecolor=kubectl
fi


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#
export PATH="$PATH:$HOME/.local/nvim-linux-x86_64/bin"

# Set up fzf key bindings and fuzzy completion
source /usr/share/doc/fzf/examples/key-bindings.zsh

# Set up fuzzy auto-completion for Zsh
source /usr/share/doc/fzf/examples/completion.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fdfind --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fdfind --type=d --hidden --exclude .git . "$1"
}

export NVM_DIR="$HOME/.nvm"

# Lazy load NVM (speeds up shell startup time tremendously)
lazy_load_nvm() {
  unset -f nvm node npm npx yarn pnpm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  # nvm's completion registers through compdef, which writes into compinit's
  # _comps map. Only load it where compinit actually ran: shells without that
  # map (non-interactive, Claude Code's snapshot shell) otherwise print
  # "compdef:153: _comps: assignment to invalid subscript range".
  if [[ ${(t)_comps} == association* && -s "$NVM_DIR/bash_completion" ]]; then
    \. "$NVM_DIR/bash_completion"
  fi
}

# Define placeholders that trigger the real load on first use
nvm() { lazy_load_nvm; nvm "$@"; }
node() { lazy_load_nvm; node "$@"; }
npm() { lazy_load_nvm; npm "$@"; }
npx() { lazy_load_nvm; npx "$@"; }
yarn() { lazy_load_nvm; yarn "$@"; }
pnpm() { lazy_load_nvm; pnpm "$@"; }

# For qt_platform stuff
export QT_QPA_PLATFORM=xcb

# Go Path
# Go lives in ~/.zshenv so non-interactive shells (and anything nvim spawns)
# can find it too. Nothing to set here.
	

# Created by `pipx` on 2024-11-12 16:23:52
export PATH="$PATH:/home/luken/.local/bin"
# alias kubectl="minikube kubectl --"
# source <(kubectl completion zsh)

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


# Added by Antigravity CLI installer
export PATH="/home/luken/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# copy file/stdin to clipboard:  clip < file  |  cmd | clip
alias clip='xclip -selection clipboard'

# Android SDK
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"

# Flutter SDK (installed 2026-08-12, stable 3.44.9, for poseperfect)
export PATH="$HOME/development/flutter/bin:$PATH"
# Binaries from `dart pub global activate`
export PATH="$HOME/.pub-cache/bin:$PATH"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

# Rust path (installed by rustup)
. "$HOME/.cargo/env"
# export PATH="$HOME/.cargo/env"

