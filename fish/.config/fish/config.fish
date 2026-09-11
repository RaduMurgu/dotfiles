source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
function fish_greeting
end

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER "nvim +Man!"
set -gx LANG en_US.UTF-8

fish_add_path -g $HOME/.local/bin

if status is-interactive
    starship init fish | source
    zoxide init fish | source
    pixi completion --shell fish | source

    alias ls='eza --color=always --group-directories-first --icons=always'
    alias cat='bat'
end
