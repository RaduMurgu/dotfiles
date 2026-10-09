# Loaded last on purpose: zsh expands aliases when a function is defined,
# so they would cause trouble for the plugins.

# eza
alias ls='eza --group-directories-first --icons=auto'
alias ll='ls -l --git'
alias la='ls -la --git'
alias lt='ls --tree --level=2'
# bat
alias cat='bat --paging=never'
# Colorize any `cmd --help` output
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias vim='nvim'
