# read by every zsh, including scripts.

typeset -U path PATH    # drop duplicates
path=(
  $HOME/.local/bin(N-/)
  $HOME/.local/bin/scripts(N-/)
  $path
)
export PATH

export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
