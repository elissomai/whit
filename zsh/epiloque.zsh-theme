ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[blue]%}‹%{$fg[red]%}"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="%{$fg[blue]%}› %{$reset_color%}"
ZSH_THEME_PYENV_PROMPT_PREFIX="%{$fg[blue]%}‹%{$fg[red]%}"
ZSH_THEME_PYENV_PROMPT_SUFFIX="%{$fg[blue]%}› %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
local return_status="%{$fg[red]%}%(?. .¡)%{$reset_color%}"

function box_name {
    hostname -s
}

function right_right {
    echo -n ""
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '¬'
}

function _pyenv_version() {
    if which pyenv &> /dev/null
    then
        local pyenv_version=$(pyenv version | awk '{print $1}')
        if [ -n "$pyenv_version" ]; then
            echo "$ZSH_THEME_PYENV_PROMPT_PREFIX$pyenv_version$ZSH_THEME_PYENV_PROMPT_SUFFIX"
        fi
    fi

}

function _virtualenv_prompt_info() {
    if [ -n "$VIRTUAL_ENV" ]; then
        if [ -f "$VIRTUAL_ENV/__name__" ]; then
            local name=`cat $VIRTUAL_ENV/__name__`
        elif [ `basename $VIRTUAL_ENV` = "__" ]; then
            local name=$(basename $(dirname $VIRTUAL_ENV))
        else
            local name=$(basename $VIRTUAL_ENV)
        fi
        echo "$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX$name$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"
    fi
}

PROMPT='%{$fg[red]%}%n%{$reset_color%} at %{$fg[yellow]%}$(box_name)%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info) %(?,,%{${fg_bold[magenta]}%}«%?»%{$reset_color%} )$(prompt_char) '
RPROMPT='%{${fg[black]}%}$(_virtualenv_prompt_info)$(_pyenv_version)%{${reset_color}%}${return_status}%{$reset_color%}$(right_right)%{$reset_color%}'

