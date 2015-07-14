# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vimcache="cd ~/.vim/tmp; rm -rf *; cd -; cd ~/.vim/backup; rm -rf *; cd -"
alias st="svn st *"
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias wget="curl -OL "
alias scn="screen -T xterm-256color -Dr"
alias npm-clean="rm -rf node_modules/; npm cache clear; npm install"
