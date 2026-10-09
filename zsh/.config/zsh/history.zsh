# atuin keeps its own database, but zsh's own history is still used by
# fc, !!, and as a fallback if atuin is ever missing

HISTFILE="$ZSH_STATE_DIR/history"
HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY      # save timestamps and durations
setopt SHARE_HISTORY         # write immediately, share between open shells
setopt HIST_IGNORE_ALL_DUPS  # drop older duplicates
setopt HIST_IGNORE_SPACE     # commands starting with a space aren't saved
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY           # !! expands into the line instead of running
