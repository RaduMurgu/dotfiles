# Loaded before plugins, so fzf/atuin can still add their own bindings.

# default, and first, because a plain bindkey writes to the active keymap.
bindkey -v
KEYTIMEOUT=1    # 10 ms after Esc instead of 400 ms; Alt-key combos still arrive in one piece

autoload -Uz edit-command-line
zle -N edit-command-line

# Navigation keys in both insert and normal mode. In normal mode an unbound
# escape sequence gets split into separate vi commands (Home's `^[OH` runs `O`).
for km in viins vicmd; do
  # Ctrl-Left/Right move by word. Ctrl-Right also accepts one word of an autosuggestion
  bindkey -M $km '^[[1;5C' forward-word
  bindkey -M $km '^[[1;5D' backward-word
  # Home / End / Delete
  bindkey -M $km '^[[H'  beginning-of-line
  bindkey -M $km '^[[F'  end-of-line
  bindkey -M $km '^[OH'  beginning-of-line
  bindkey -M $km '^[OF'  end-of-line
  bindkey -M $km '^[[3~' delete-char
  # Alt-E: edit the current command in $EDITOR
  bindkey -M $km '^[e' edit-command-line
done

# Insert mode: use the emacs deletion widgets. The vi versions refuse to delete
# past the point where insert mode was entered, and ignore select-word-style.
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^U' backward-kill-line

# Treat / - . _ as word boundaries, so Ctrl-W deletes one path component
autoload -Uz select-word-style
select-word-style bash

# Text objects for quotes and brackets: ci" da( yi{ va' ...
autoload -Uz select-bracketed select-quoted
zle -N select-bracketed
zle -N select-quoted
for km in viopp visual; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do bindkey -M $km $c select-bracketed; done
  for c in {a,i}{\',\",\`}; do bindkey -M $km $c select-quoted; done
done

unset km c
