function git-browse {
    gbrowsevar=$(git config --get remote.origin.url)
    printf "${gbrowsevar}" | awk -F "@" '{print $2}' | awk -F " " '{print $1}' | sed 's/:/\//g' | sed 's/.git//g' | awk '{print "http://"$1}' | xargs open
}
