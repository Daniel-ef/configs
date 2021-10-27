#eval "$(docker-machine env taix)"
#eval $(thefuck --alias)

if [[ $(uname) = "Linux" ]]; then
    export CMAKE_OPTS="-DUSE_CCACHE=1"
fi

alias gb='git branch'
alias gch='git checkout'
alias gst='git status'
alias gll='git pull'
alias gsh='git push'
alias ls='ls -Gh'
alias gclean='git reset --hard && git clean -fd'
alias gsm='git submodule update --init --recursive'
alias gbnew='git checkout -B'
alias arc-mount="arc mount -m $HOME/arc/arcadia -S $HOME/arc/store --object-store $HOME/arc/object-store --allow-root"
alias arc-remove-merged="arc branch --merged trunk | grep -v trunk | xargs -L 1 arc branch -d"

alias ab='arc branch'
alias ach='arc checkout'
alias ast='arc status'
alias all='arc pull'
alias ash='arc push'
alias aclean='arc reset --hard && arc clean -dx'

# Custom bash prompt

set_prompt() {
    Last_Command=$?

    Blue='\[\e[01;34m\]'
    White='\[\e[01;37m\]'
    Red='\[\e[01;31m\]'
    Green='\[\e[01;32m\]'
    Yellow='\[\e[0;33m\]'
    Cyan='\[\e[0;36m\]'

    End='\[\e[m\]' # End color
    Reset='\[\e[00m\]'

    FancyX='\342\234\227'
    Checkmark='\342\234\223'
    Penguin=$(printf '\xf0\x9f\x90\xa7')
    Apple=$(printf '\xF0\x9F\x8D\x8F')

    Smart_return_code=""
    if [[ $Last_Command == 0 ]]; then
        Smart_return_code+="$Green$Checkmark$End"
    else
        Smart_return_code+="$Red$FancyX$End"
    fi

    git_or_env=0

    PS1=""
    PS1+="$Red\\u$End@$Green\\H$End\n"
    if [[ -n "$VIRTUAL_ENV" ]]; then
        PS1+=" (`basename $VIRTUAL_ENV`)"
        git_or_env+=1
    fi
    if [[ $git_or_env != 0 ]]; then
        PS1+="\n"
    fi

    Os_logo=""
    if [[ `uname -a` == *"osx"* ]]; then
        Os_logo=$Apple
    elif [[ `uname -a` == *"Linux"* ]]; then
        Os_logo=$Penguin
    fi

    PS1+="$Cyan\\t \\d "
    PS1+="$Yellow\\w$End [$Smart_return_code] $Os_logo \\$ $Reset"
}
PROMPT_COMMAND='set_prompt'

. "$HOME/.cargo/env"
