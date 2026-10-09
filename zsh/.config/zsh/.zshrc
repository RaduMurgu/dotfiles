# ~/.config/zsh/.zshrc — interactive shell setup.
# Order matters: completion before plugins, aliases last.

ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"    # zcompdump, completion cache
ZSH_STATE_DIR="$XDG_STATE_HOME/zsh"    # history
ZSH_PLUGIN_DIR="$XDG_DATA_HOME/zsh"    # cloned plugins
[[ -d $ZSH_CACHE_DIR ]] || mkdir -p "$ZSH_CACHE_DIR"
[[ -d $ZSH_STATE_DIR ]] || mkdir -p "$ZSH_STATE_DIR"

# Ghostty shell integration (automatic injection can't work with ZDOTDIR set in /etc/zsh/zshenv)
if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
fi
export LS_COLORS="$(vivid generate catppuccin-mocha)"

for config in options history keybinds completion plugins aliases; do
  source "$ZDOTDIR/$config.zsh"
done
unset config

