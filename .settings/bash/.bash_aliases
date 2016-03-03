# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vimcache="cd ~/.vim/tmp; rm -rf *; cd -; cd ~/.vim/backup; rm -rf *; cd -"
alias st="svn st *"
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias wget="curl -OL "
alias sc="screen -T xterm-256color -D -RR"
alias npm-clean="rm -rf node_modules/; npm cache clear; npm install"
alias mxlookup="nslookup -type=mx "
alias textedit="open -a TextEdit "
alias open-gui="open -t "
