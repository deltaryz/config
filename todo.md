use the info in the screenshot to automatically get the correct distro name (from ID/ID_LIKE) and invoke neofetch with the distro name

* create an environment variable with the shorthand distro name, make sure to filter out 'arm'/etc
* append "_small" to the command used to invoke neofetch in the fish startup script

misc reminders:
* startup:
    * `git config --global credential.helper store`
    * install neovim, vim, fish, git, ssh, mosh, npm, node, starship (if possible), neofetch, rsync
    * install nix (ideally with its own script)
