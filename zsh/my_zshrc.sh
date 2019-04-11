source ~/.zplug/init.zsh
source ~/.dotfiles/zsh/zshrc_useful.sh

zplug "wbinglee/zsh-wakatime"

# syntax
zplug "chrissicool/zsh-256color"
zplug "Tarrasch/zsh-colors"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "ascii-soup/zsh-url-highlighter"

# program
zplug "voronkovich/mysql.plugin.zsh"

# tools
zplug "marzocchi/zsh-notify"
zplug "oknowton/zsh-dwim"

export LC_CTYPE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export EDITOR=vim

eval "$(pyenv init -)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.nodebrew/current/bin:$PATH"
if which jenv > /dev/null; then
   export JENV_ROOT=/usr/local/var/jenv
  eval "$(jenv init -)"
fi
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PATH=/usr/local/bin:$PATH
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/libxslt/bin:$PATH"
export PATH="/usr/local/opt/libiconv/bin:$PATH"
export GOPATH="$HOME/dev"
export GOROOT="$(go env GOROOT)"
export PATH=$PATH:$GOPATH/bin
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
export PGDATA='/usr/local/var/postgres'
export PATH="/usr/local/opt/openssl/bin:$PATH"

## RPROMPT
RPROMPT=$'`branch-status-check`' # %~はpwd
setopt prompt_subst

## zshの設定
setopt auto_param_keys
# 補完候補に色つける
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


# {{{ methods for RPROMPT
# fg[color]表記と$reset_colorを使いたい
# @see https://wiki.archlinux.org/index.php/zsh
autoload -U colors; colors
function branch-status-check {
    local prefix branchname suffix
        # .gitの中だから除外
        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
            return
        fi
        branchname=`get-branch-name`
        # ブランチ名が無いので除外
        if [[ -z $branchname ]]; then
            return
        fi
        prefix=`get-branch-status` #色だけ返ってくる
        suffix='%{'${reset_color}'%}'
        echo ${prefix}'['${branchname}']'${suffix}
}
function get-branch-name {
    # gitディレクトリじゃない場合のエラーは捨てます
    echo `git rev-parse --abbrev-ref HEAD 2> /dev/null`
}
function get-branch-status {
    local res color
        output=`git status --short 2> /dev/null`
        if [ -z "$output" ]; then
            res=':' # status Clean
            color='%{'${fg[green]}'%}'
        elif [[ $output =~ "[\n]?\?\? " ]]; then
            res='?:' # Untracked
            color='%{'${fg[yellow]}'%}'
        elif [[ $output =~ "[\n]? M " ]]; then
            res='M:' # Modified
            color='%{'${fg[red]}'%}'
        else
            res='A:' # Added to commit
            color='%{'${fg[cyan]}'%}'
        fi
        # echo ${color}${res}'%{'${reset_color}'%}'
        echo ${color} # 色だけ返す
}

PROMPT=$'%{${fg[cyan]}%}[%T] %~%{${reset_color}%} \n%# '

zmodload zsh/datetime
reset_tmout() { TMOUT=$[60-EPOCHESECONDS%60] }
precmd_functions=($precmd_fuctions reset_tmout)
redraw_tmout()  { zle reset-prompt; reset_tmout }
TRAPALRM() { redraw_tmout }

# function chpwd() {echo -ne "\033]0;${PWD##*/}\007"}

# hyper-tab-icon
precmd() {
  pwd=$(pwd)
  cwd=${pwd##*/}
  print -Pn "\e]0;$cwd\a"
}

preexec() {
#   if overridden; then return; fi
   printf "\033]0;%s\a" "${1%% *} | $cwd"
}

# config peco
bindkey '^]' peco-src

function peco-src() {
  local src=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N peco-src

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

source <(stern --completion=zsh)
