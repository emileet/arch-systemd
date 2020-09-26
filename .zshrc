export PATH=$HOME/.local/bin:$HOME/scripts:$PATH
export ZSH=/home/$(id -un -- 1000)/.oh-my-zsh

ZSH_THEME="robbyrussell"
ENABLE_CORRECTION="true"
plugins=(git)

source $ZSH/oh-my-zsh.sh
