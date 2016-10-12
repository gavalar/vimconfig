# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vimcache="cd ~/.vim/tmp; rm -rf *; cd -; cd ~/.vim/backup; rm -rf *; cd -"
alias st="svn st *"
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias sc="screen -T xterm-256color -D -RR"
alias npm-clean="rm -rf node_modules/; npm cache clear; npm install"
alias gc-web-ui="cd ../web-ui/; npm run build; cd -; npm run build; npm start"
alias mxlookup="nslookup -type=mx "
alias textedit="open -a TextEdit "
alias open-gui="open -t "
alias dnsFlush="sudo killall -HUP mDNSResponder"
alias chPhp56="cd /usr/local; sudo rm php5; sudo ln -s php5-5.6.25-20160831-101628 php5; sudo /usr/sbin/apachectl restart; echo 'PHP 5.6 Installed and apache Restarted'; open -a '/Applications/Google Chrome.app' 'http://localhost/phpinfo.php'"
alias chPhp7="cd /usr/local; sudo rm php5; sudo ln -s php5-7.0.10-20160831-102733 php5; sudo /usr/sbin/apachectl restart; echo 'PHP 7 Installed and apache Restarted'; open -a '/Applications/Google Chrome.app' 'http://localhost/phpinfo.php'"
