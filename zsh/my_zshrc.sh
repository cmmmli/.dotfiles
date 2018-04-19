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


eval "$(rbenv init -)"
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
export PATH="$HOME/.goenv/bin:$PATH"
eval "$(goenv init -)"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/libxslt/bin:$PATH"
export PATH="/usr/local/opt/libiconv/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="/usr/local/opt/curl/bin:$PATH"

alias be='bundle exec'
alias kces='kubectl -n elasticsearch-staging'
alias kcep='kubectl -n elasticsearch-production'
alias kce='kubectl -n elasticsearch'
alias spotlightreindex='sudo mdutil -E /'
alias status='git status'
alias diff='git diff'
alias lla='ls -la'
alias l1='ls -1'
alias la1='ls -1a'

PROMPT="%{${fg[cyan]}%}[%T]%{${reset_color}%} %~
%# "

# zstyle ':vcs_info:*' formats '%F{green}[%b]%f'
# zstyle ':vcs_info:*' actionformats '%F{red}[%b|%a]%f'

zmodload zsh/datetime
reset_tmout() { TMOUT=$[60-EPOCHESECONDS%60] }
precmd_functions=($precmd_fuctions reset_tmout)
redraw_tmout()  { zle reset-prompt; reset_tmout }
TRAPALRM() { redraw_tmout }

function chpwd() {echo -ne "\033]0;${PWD##*/}\007"}

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

source <(stern --completion=zsh)
