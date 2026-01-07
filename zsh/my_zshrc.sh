eval "$(sheldon source)"

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
export AQUA_GLOBAL_CONFIG=$HOME/.config/aqua.yaml
export AQUA_PROGRESS_BAR=true

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
export PATH="/opt/homebrew/opt/pnpm/bin:$PATH"
export PATH="/usr/local/opt/krb5/bin:$PATH"
export PATH="/usr/local/opt/krb5/sbin:$PATH"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$(aqua root-dir)/bin:$PATH"

export PAGER=less

# eval "$(zellij setup --generate-auto-start zsh)"

setopt magic_equal_subst

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
source <(skaffold completion zsh)

autoload -U +X bashcompinit && bashcompinit

# Copyright (c) npm, Inc. and Contributors
# All rights reserved.
#

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

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

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/komori/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

alias beep='for i in {1..3}; do afplay /System/Library/Sounds/Morse.aiff; done'

terraform -install-autocomplete
if type terraform &> /dev/null; then
  complete -C terraform terraform
fi


### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/komori/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/komori/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/komori/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/komori/google-cloud-sdk/completion.zsh.inc'; fi

alias gwt='cd "$(git worktree list | peco | awk "{print \$1}")"'
eval "$(mise activate zsh)"

complete -o nospace -C /Users/komori/.local/share/aquaproj-aqua/pkgs/http/releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_darwin_arm64.zip/terraform terraform

tre() { command tre "$@" -e vim && source "/tmp/tre_aliases_$USER" 2>/dev/null; }

# Added by Antigravity
export PATH="/Users/komori/.antigravity/antigravity/bin:$PATH"
