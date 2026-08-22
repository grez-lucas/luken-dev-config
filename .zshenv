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

# Go. Here rather than in ~/.zshrc because /etc/profile used to be what put a
# `go` on PATH for non-interactive shells, and that line was removed along
# with the old /usr/local/go install. Without this, `go` exists only in
# interactive shells and anything nvim spawns (gopls, Mason, golangci-lint)
# fails to find it when nvim is launched from a GUI rather than a terminal.
#
# brew's go@1.25 is the single Go install and is keg-only, so it needs an
# explicit PATH entry. Do NOT export GOROOT; `go` infers it from its own
# location, and hardcoding it once pinned a newer driver to an older
# toolchain ("compile: version go1.24.0 does not match go tool version
# go1.27.0").
#
# GOTOOLCHAIN=local stops `go` downloading another toolchain into the module
# cache when a go.mod names a newer version; on "auto" that had accumulated
# 13 toolchains / 4.6G.
export GOPATH="$HOME/go"
export GOTOOLCHAIN=local
export PATH="/home/linuxbrew/.linuxbrew/opt/go@1.25/bin:$GOPATH/bin:$PATH"
