# status --is-interactive means if the fish is connected to a keyabord???
if status --is-interactive 
    # neofetch
    # starfetch
    # bunnyfetch
    ## hilbish
    if type -q tmux && not set -q TMUX
      # exec tmux -2 
    end
    if type -q mcfly
      mcfly init fish | source
    end
    if type -q starship
      starship init fish | source
    end
end

## Set values

# Hide welcome message
set fish_greeting

set VIRTUAL_ENV_DISABLE_PROMPT 1

# Replace some more things with better alternatives
if type -q bat
    alias cat='bat --style header --style rule --style snip --style changes --style header'
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -x MANROFFOPT "-c" # to fix formating problems
end

set -g fish_escape_delay_ms 10
set -gx MCFLY_RESULTS 25

## Export variable need for qt-theme
if type qtile >>/dev/null 2>&1
    set -x QT_QPA_PLATFORMTHEME qt5ct
end

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

# EDITOR (<C-e>)
set -Ux EDITOR nvim

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
    source ~/.fish_profile
end

#Add DOOOOOOOOOOOOOOM
if test -d ~/.emacs.d/bin
    if not contains -- ~/.emacs.d/bin $PATH
        set -p PATH ~/.emacs.d/bin
    end
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end

# Add customScripts to PATH
if test -d ~/customScripts
    if not contains -- ~/customScripts $PATH
        set -p PATH ~/customScripts
    end
end

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T ' | tac
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## Useful aliases
# Replace ls with exa
if type -q exa
    alias ls='exa --color=always --group-directories-first --icons' # preferred listing
    alias lsf='exa | fzf' # preferred listing
    alias la='exa -al --color=always --group-directories-first --icons' # all files and dirs
    alias ll='exa -l --color=always --group-directories-first --icons' # long format
    alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
    alias l.="exa -a | egrep '^\.'" # show only dotfiles
    alias ip="ip -color"
end

# Common use
alias tarnow='tar -acf '
alias untar='tar -xvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short' # Hardware Info

#customAliases
alias pac='sudo pacman'
alias z='sudo zypper install'
alias zy='sudo zypper'
alias wgoff="wg-quick down /home/byakuya/wgL.conf"
alias wgon="wg-quick up /home/byakuya/wgL.conf"
alias "gcd"="git clone --depth 1"
# alias "re"="sudo nixos-rebuild switch"
alias "cf"="nvim ~/.config/fish/config.fish" # something strange, just nvim doesn't work? NO, it works now
alias "shutdown"="sudo shutdown"

#one-letter-aliasses (qberik)
alias unrar='unar'
# alias z='zathura'
alias p='python3'
alias f='feh'
alias v='nvim'
alias hx='helix'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"
