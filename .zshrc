export ZSH=$HOME/.oh-my-zsh
export TERM="xterm-256color"

# Powerline 9k theme
source ~/.fonts/*.sh
POWERLEVEL9K_MODE='awesome-fontconfig'
export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon user dir vcs dir_writable)
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S \uE868  %d.%m.%y}"
export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs ram load)
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
export POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1
DISABLE_AUTO_TITLE=true

ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Oh My ZSH Plugins
plugins=(
  git
  colorize
  dircycle
  python
  zsh-autosuggestions
  zsh-syntax-highlighting
  encode64
  last-working-dir
  lol
  command-not-found
  sudo
  debian
  wd
  tmux
  alias-tips
  colored-man-pages
  docker
  zsh-completions
)

source $ZSH/oh-my-zsh.sh

# Plugin configuration
export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES=":3 hackzo hackzor _"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"


export EDITOR='vim'

# Aliases
alias cat=bat
alias cert='openssl x509 -inform pem -noout -text -in'
alias sql='mysql -uroot -h 127.0.0.1 -ptoor'
alias bd='base64 -d'
alias d='docker'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias nano='vim'
alias sublist3r='python ~/tools/Sublist3r/sublist3r.py'
alias t='todo'
alias v='vim'
alias dns="nmcli dev show wlp4s0 | awk '/DNS/ { print \$2 }'"
alias myip='curl -s ifconfig.co/json | jq'
alias zshrc='$EDITOR $HOME/.zshrc'
alias ..='cd ..'
alias ....='cd ../..'
alias df='df -h'
alias py3='python3.6'
alias py='python2.7'
alias serve='python -m SimpleHTTPServer'
alias vpn='sudo $HOME/tools/protonvpn-cli/protonvpn-cli.sh -connect'
alias vpn-disconnect='sudo $HOME/tools/protonvpn-cli/protonvpn-cli.sh -disconnect'
alias dig='dig +short'

function hostadd {
  echo "$2 $1" | sudo tee --append /etc/hosts
}

function quietly {
  $@ >/dev/null
}

function mkcd {
  mkdir $1
  cd $1
}

alias copy='xclip -selection clipboard'
# Note: this takes precedence over the default 'paste' command
alias paste='xclip -o -selection clipboard'

function vm {
  if [[ $1 = "seamless" ]] ; then
    vmname=$2
    VBoxManage setextradata "$vmname" GUI/Seamless on
  else
    vmname=$1
    VBoxManage setextradata "$vmname" GUI/Seamless off
  fi
  
  echo "Starting $vmname"
  vboxmanage startvm "$vmname"
  
}
alias kali='VBoxManage setextradata VM_NAME GUI/Seamless off && vboxmanage start kali'
alias kali-terminal='VBoxManage setextradata VM_NAME GUI/Seamless on && vboxmanage start kali'

function extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)        tar xjf $1        ;;
      *.tar.gz)         tar xzf $1        ;;
      *.bz2)            bunzip2 $1        ;;
      *.rar)            unrar x $1        ;;
      *.gz)             gunzip $1         ;;
      *.tar)            tar xf $1         ;;
      *.tbz2)           tar xjf $1        ;;
      *.tgz)            tar xzf $1        ;;
      *.zip)            unzip $1          ;;
      *.Z)              uncompress $1     ;;
      *.7z)             7zr e $1          ;;
      *)                echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


# Key bindings
ALT='^['
CTRL='^'

bindkey -s "$ALT\w" 'cd ~/workspace^M'
bindkey -s "$ALT\d" 'cd ~/Downloads^M'
bindkey -s "$CTRL " 'git status^M'
bindkey -s "$CTRL$ALT" 'ls -lah^M'

function insert-last-command-output() {
  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}

function smartssh() {
  SSH_ASKPASS=/home/christophetd/ssh_login.py SSH_HOST=$2 setsid ssh $1@$2
}

zle -N insert-last-command-output
bindkey "$ALT\y" insert-last-command-output

bindkey -s "^[e" 'chmod +x !!0 && !-1^M^M'

# Bind 'home' and 'end' keys to start and end of line
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# Various configuration
export PATH=$PATH:~/.bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load environment variables from .env (sensitive env variables that I don't want to commit to Github)
if [[ -f ~/.env ]]; then
  source ~/.env
fi
if [[ -f ~/.firewall_rules ]]; then
  source ~/.firewall_rules
fi
if [[ -f ~/.hkrc ]]; then
  source ~/.hkrc
fi

# Shell startup code
cd $HOME

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GO_HOME="/home/christophetd/workspace/go"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/christophetd/.bin/vault vault
