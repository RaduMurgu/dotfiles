# zmodload zsh/zprof    # Profiling to troubleshoot slow startup

export EDITOR="nvim"
export VISUAL="nvim"
export PATH="$HOME/.local/bin:$PATH"
export MANPAGER='nvim +Man!'
export PAGER="bat"

export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export BAT_THEME="Catppuccin Mocha"

export PATH="$HOME/.ghcup/bin:$PATH"


source ~/.config/zsh/cachyos-config-adjusted.zsh

# Pixi autocompletion
# eval "$(pixi completion --shell zsh)"

fpath=("$HOME/.config/zsh/functions/" $fpath)
autoload -Uz tdl

eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"

bindkey -v

# zprof   # Profiling to troubleshoot slow startup
