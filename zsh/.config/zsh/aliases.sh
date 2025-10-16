alias git-delete-merged='git branch --merged | grep -Ev "(^\*|master|main|dev)" | xargs git branch -d'

alias gcof='git checkout $(git branch --sort=-committerdate | fzf --reverse --height=20% --info=inline)'

alias nixbox:start='utmctl start NixOS &> /dev/null && ssh -y nixbox.local && utmctl suspend NixOS'
alias nixbox:connect='ssh -y nixbox.local'
alias nixbox:stop='utmctl suspend NixOS'
alias nixbox:shutdown='utmctl stop NixOS'
