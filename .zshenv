# ~/.zshenv - sourced by EVERY zsh invocation, including non-interactive,
# non-login shells (e.g. jobs spawned by neovim/Mason). Keep it fast: no nvm.sh.
#
# Make nvm's default node visible on PATH so Mason and other subprocesses can
# find node/npm without the interactive lazy-load functions in ~/.zshrc.
export NVM_DIR="$HOME/.nvm"

if [ -d "$NVM_DIR/versions/node" ]; then
  # Resolve nvm's 'default' alias to a concrete version dir. The alias file may
  # hold a version ("22.14.0") or point at another alias ("lts/*", "node").
  _nvm_default="$(cat "$NVM_DIR/alias/default" 2>/dev/null)"
  _nvm_node_dir=""
  if [ -n "$_nvm_default" ] && [ -d "$NVM_DIR/versions/node/v$_nvm_default" ]; then
    _nvm_node_dir="$NVM_DIR/versions/node/v$_nvm_default"
  else
    # Fallback: highest installed version (sort -V).
    _nvm_node_dir="$NVM_DIR/versions/node/$(ls -1 "$NVM_DIR/versions/node" 2>/dev/null | sort -V | tail -1)"
  fi
  if [ -n "$_nvm_node_dir" ] && [ -d "$_nvm_node_dir/bin" ]; then
    export PATH="$_nvm_node_dir/bin:$PATH"
  fi
  unset _nvm_default _nvm_node_dir
fi

# Go and other brew tools. Here rather than in ~/.zshrc because zsh sources
# .zshrc only for interactive shells, and /etc/profile used to be what put a
# `go` on PATH for everything else until the old /usr/local/go install was
# removed. Without this, anything nvim shells out to (gopls, Mason,
# golangci-lint, buf) fails to find its binary.
#
# brew's `go` formula is the single Go install. It is not keg-only, so adding
# brew's bin dir covers go, buf and the rest in one entry. `brew shellenv` is
# deliberately not eval'd here: it shells out, and this file runs on every
# zsh invocation.
#
# Do NOT export GOROOT; `go` infers it from its own location. Hardcoding it
# once pinned a newer driver to an older toolchain:
#   compile: version "go1.24.0" does not match go tool version "go1.27.0"
#
# GOTOOLCHAIN=local keeps the installed Go the only one that can ever run. On
# "auto" the module cache had silently accumulated 13 toolchains / 4.6G.
export GOPATH="$HOME/go"
export GOTOOLCHAIN=local
export PATH="/home/linuxbrew/.linuxbrew/bin:$GOPATH/bin:$PATH"

# rustup's ~/.cargo/bin. The only zsh copy: .zshrc runs after this file, and
# ~/.cargo/env skips the prepend once the dir is on PATH. Keep in step with
# ~/.profile.
. "$HOME/.cargo/env"
