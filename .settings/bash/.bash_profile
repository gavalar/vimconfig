# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  source ~/.bashrc;
fi

export NVM_DIR="$HOME/.nvm"

function iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
}
