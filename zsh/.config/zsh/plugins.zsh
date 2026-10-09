# This load order is on purpose

# 1. fzf: aspect, Ctrl-T (files), Alt-C (dirs), `**<Tab>`.
# It also binds Ctrl-R, but that ends up owned by atuin, since we load it after this.
export FZF_DEFAULT_OPTS="--popup center --style full \
  --color=bg+:#313244,bg:-1,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --color=selected-bg:#45475a,border:#6c7086,label:#cdd6f4"
export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then eza --tree --level=1 --color=always {}; else bat --color=always --style=numbers --line-range=:300 {}; fi'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always {}'"
source <(fzf --zsh)

# 2. fzf-tab: after compinit and fzf (so it owns Tab), before any plugin
#    that wraps widgets.
source "$ZSH_PLUGIN_DIR/fzf-tab/fzf-tab.plugin.zsh"

# 3. Tools that register completions: these need compinit to have run.
eval "$(zoxide init zsh --cmd cd)"
# eval "$(pixi completion --shell zsh)"

# 4. atuin: after fzf so it gets Ctrl-R and Up. It also registers itself as
#    a zsh-autosuggestions strategy, so it must come before that.
eval "$(atuin init zsh)"

# 5. Widget-wrapping plugins go last.
source "$ZSH_PLUGIN_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
source "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"

# 6. Prompt
eval "$(starship init zsh)"
