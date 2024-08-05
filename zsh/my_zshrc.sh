source ~/.zplug/init.zsh

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

if [ -e $(brew --prefix)/share/zsh-completions ]; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi
source ~/dev/src/github.com/cmmmli/.dotfiles/zsh/zshrc_useful.sh

export LC_CTYPE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export EDITOR=vim

typeset -U path PATH
path=(
	/opt/homebrew/bin(N-/)
	/usr/local/bin(N-/)
	$path
)

export VOLTA_HOME="$HOME/.volta"

export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/libxslt/bin:$PATH"
export PATH="/usr/local/opt/libiconv/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export GOPATH="$HOME/dev"
export GOROOT="$(go env GOROOT)"
export PATH=$PATH:$GOPATH/bin
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PGDATA='/usr/local/var/postgres'
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$(=brew --prefix)/opt/mysql@5.7/bin:$PATH"
export PATH="$PATH:$HOME/bin"
export PATH="/usr/local/aws/bin:$PATH"
export PATH="/usr/local/opt/v8@3.15/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.9/libexec/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/Applications/Alacritty.app/Contents/MacOS:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/opt/pnpm@8/bin:$PATH"
export PATH="/usr/local/opt/krb5/bin:$PATH"
export PATH="/usr/local/opt/krb5/sbin:$PATH"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

export PAGER=less

if (( $+commands[sw_vers] )) && (( $+commands[arch] )); then
	[[ -x /usr/local/bin/brew ]] && alias brew="arch -arch x86_64 /usr/local/bin/brew"
	alias x64='exec arch -x86_64 /bin/zsh'
	alias a64='exec arch -arm64e /bin/zsh'
	switch-arch() {
		if  [[ "$(uname -m)" == arm64 ]]; then
			arch=x86_64
		elif [[ "$(uname -m)" == x86_64 ]]; then
			arch=arm64e
		fi
		exec arch -arch $arch /bin/zsh
	}
fi

setopt magic_equal_subst

# add color to `man` command
export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.

## zshの設定
setopt auto_param_keys
# 補完候補に色つける
zstyle ':completion:*' list-colors "${LS_COLORS}"

zmodload zsh/datetime
reset_tmout() { TMOUT=$[60-EPOCHESECONDS%60] }
precmd_functions+=($precmd_fuctions reset_tmout)
redraw_tmout()  { zle reset-prompt; reset_tmout }
TRAPALRM() { redraw_tmout }

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

fpath+=~/.zfunc
autoload -Uz compinit && compinit

source <(stern --completion=zsh)
source <(gh completion -s zsh)
[[ /opt/homebrew/bin/kubectl ]] && source <(kubectl completion zsh)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/komori/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/komori/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/komori/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/komori/google-cloud-sdk/completion.zsh.inc'; fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
# Copyright (c) npm, Inc. and Contributors
# All rights reserved.
#

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

alias snowsql=/Applications/SnowSQL.app/Contents/MacOS/snowsql


# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true


export VOLTA_FEATURE_PNPM=1

# pnpm
export PNPM_HOME="/Users/komori/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

eval "$(starship init zsh)"

# 1password cli completion
eval "$(op completion zsh)"; compdef _op op
