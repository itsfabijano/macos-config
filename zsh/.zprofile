# Add .NET Core SDK tools
export PATH="$PATH:$HOME/.dotnet/tools"

export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"


eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$PATH:$HOME/.dotfiles/bin"

source $(brew --prefix nvm)/nvm.sh

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

