# Aliases

# Command flags
alias la="ls -hal"
alias rsync="rsync -av --progress"
# Programs
alias vim="nvim"
alias nano="nvim"

# Distro-specific config
set distrostring (cat /etc/issue)

# Alpine
if string match -q "*Alpine*" $distrostring
    alias apk="sudo apk"
    alias rc-update="sudo rc-update"
    alias gimme="sudo apk update && sudo apk add"
    alias yeet="sudo apk del"

# Debian / Ubuntu
else if string match -q "*Ubuntu*" $distrostring || string match -q "*Debian*" $distrostring
    alias apt="sudo apt"
    alias systemctl="sudo systemctl"
    alias gimme="sudo apt update && sudo apt install"
    alias yeet="sudo apt autoremove"

# Arch / Manjaro
else if string match -q "*Arch*" $distrostring || string match -q "*Manjaro*" $distrostring
    alias pacman="sudo pacman"
    alias systemctl="sudo systemctl"
    alias gimme="sudo pacman -Sy"
    alias yeet="pacman -Rs"

end


# SSH shortcuts
alias fz="mosh delta@floof.zone"
alias cs="mosh delta@cameronseid.com"
alias hfz="mosh delta@home.floof.zone"


# - - - - - - -


# This is executed when an interactive shell starts
function fish_greeting -d "Interactive shell startup"

    # only launch starship if we have it installed
    if silentexec which starship
        starship init fish | source
    end

    # Launch tmux, or connect to an existing session
    # variable "USETMUX" determines whether we do this
    if [ -n "$USETMUX" ] && [ -z "$TMUX" ]
        tmux attach || tmux new
    end

    # Wipe screen and show neofetch
    clear && neofetch

end

# Permanently add the given argument to PATH
function addpath -d "Permanently adds the given argument to PATH"
    set -U fish_user_paths $argv $fish_user_paths
end

# Set an environment variable permanently
function addenv -d "Permanently sets an environment variable"
    set -U $argv[1] $argv[2]
end

# Run a command silently
function silentexec -d "Run a command silently"
    # TODO: find a way to do this without creating junk files
    rm -rf ~/.junk && mkdir ~/.junk
    set temp (mktemp -p ~/.junk)
    $argv &> $temp
    return $status
end
