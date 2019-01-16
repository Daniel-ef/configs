#eval "$(docker-machine env taix)"

export CMAKE_OPTS="-DUSE_CCACHE=1"
export CCACHE_PREFIX="distcc"

alias gb='git branch'
alias gch='git checkout'
alias gst='git status'
alias gll='git pull'
alias gsh='git push'
alias ls='ls -Gh'

# Custom bash prompt

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "${BRANCH}${STAT}"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

set_prompt() {
    Last_Command=$?

    Blue='\[\e[01;34m\]'
    White='\[\e[01;37m\]'
    Red='\[\e[01;31m\]'
    Green='\[\e[01;32m\]'
    Yellow='\e[0;33m\]'
    Cyan='\e[0;36m\]'

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

    git_branch=`parse_git_branch`

    PS1=""
    PS1+="$Red\\u$End@$Green\\H$End\n"
    if [[ $git_branch != "" ]]; then
        PS1+="[$Yellow$git_branch$End]\n"
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

