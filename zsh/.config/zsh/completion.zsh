# fpath must be extended before compinit because it scans fpath once when it runs.
fpath=("$ZSH_PLUGIN_DIR/zsh-completions/src" $fpath)

autoload -Uz compinit
compinit -d "$ZSH_CACHE_DIR/zcompdump-$ZSH_VERSION"

# Some completers cache results; keep that out of $HOME too.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_CACHE_DIR/zcompcache"

# Fish-like matching
# case-insensitive, then across - _ . boundaries, then substring anywhere in the word.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' '+r:|[._-]=* r:|=*' '+l:|=* r:|=*'

setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# Complete dotfiles without typing the leading dot:
_comp_options+=(globdots)

### fzf-tab settings ###
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-flags --bind=tab:accept
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'
