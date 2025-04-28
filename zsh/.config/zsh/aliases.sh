alias git-delete-merged='git branch --merged | grep -Ev "(^\*|master|main|dev)" | xargs git branch -d'

alias gcof='git checkout $(git branch --sort=-committerdate | fzf --reverse --height=20% --info=inline)'
