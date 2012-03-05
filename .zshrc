# START: EXPORTS
export ARCHFLAGS='-arch x86_64'
export PATH=$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH:$HOME/local/bin
export GREP_OPTIONS='--color=auto' 
export GREP_COLOR='3;33'
export GEM_HOME=~/.gem/ruby/1.8
export EDITOR=vim
export TERM=xterm-256color
export LSCOLORS=gxfxcxdxbxegedabagacad
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL=
export FL_APP_BUILD=/Developer/SDKs/Flex3/bin/mxmlc
export CLOJURE_CLASSPATH=$HOME/Java/lib/clojure/clojure.jar:$HOME/Java/lib/clojure-contrib/clojure-contrib.jar
export CLOJURESCRIPT_HOME=$HOME/Code/Vendor/clojurescript
export GRADLE_HOME=/opt/local/share/java/gradle
export ACTIVEMQ_HOME=/usr/local/apache-activemq
export JAVA_HOME=/Library/Java/Home
export PGDATA=/usr/local/var/postgres
export WORDCHARS=
export NODE_PATH=/usr/local/lib/node
# For GO:
export GOROOT=`brew --prefix go`
export GOBIN=/usr/local/bin
export GOARCH=amd64
export GOOS=darwin
# END: EXPORTS

# Emacs key bindkings
bindkey -e


# HISTORY
HISTSIZE=600
SAVEHIST=600
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY 
setopt INC_APPEND_HISTORY 
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# MISC CONFIG
setopt prompt_subst
setopt complete_in_word         # Not just at the end
setopt always_to_end            # When complete from middle, move cursor
setopt nohup										# In general, we don't kill background jobs upon logging out

autoload -U compinit && compinit                                                                                       
zmodload -i zsh/complist

zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:*' enable git #svn cvs 

# Enable completion caching, use rehash to clear
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Fallback to built in ls colors
zstyle ':completion:*' list-colors ''

# Make the list prompt friendly
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

# Make the selection prompt friendly when there are a lot of choices
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Add simple colors to kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# insert all expansions for expand completer
# zstyle ':completion:*:expand:*' tag-order all-expansions
 
# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
 
# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:scp:*' tag-order files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

# Force 'sudo zsh' to start root as a logging shell to avoid problems with environment clashes:
function sudo {
	if [[ $1 = "zsh" ]]; then
        command sudo /opt/local/bin/zsh -l
	else
        command sudo "$@"
	fi
}

# function brew {
#   if [[ $1 == "upgrade" ]]; then
#     command brew update
#     echo Upgrading the following packages: `brew outdated`
#     for recipe in $(brew outdated | awk '{print $1}'); do
#       command brew rm $recipe
#       command brew install $recipe
#     done
#   else
#     command brew $*
#   fi
# }

function proxy {
  if [ ! -d $HOME/Code/Relevance ]; then
    echo "The Relevance TrueCrypt volume must be mounted first!"
  else
    if [ "$1" = "ias" ]; then
      export JUMPHOST_HOSTNAME=iasjump.icsl.net
      export JUMPHOST_PORT=2222
      echo "Connecting to iasjump.icsl.net:2222..."
    else
      export JUMPHOST_HOSTNAME=i2jump.icsl.net
      export JUMPHOST_PORT=22
      echo "Connecting to i2jump.icsl.net:22..."
    fi
    $HOME/Code/Relevance/vzb-jumphost-proxy/proxy.sh &> /dev/null &
  fi
}
function vack {
  mvim -p $(ack -l $@ | xargs) &> /dev/null &
}

function diffx {
  echo "diff --git a/$1 b/$2 $(diff -u $1 $2)" | gitx --all
}
     
function reload! {
  echo Restarting passenger...
  touch tmp/restart.txt
}

function push_configs {
  pushd
  cd ~/projects/configs
  git add .
  git ci -a
  git push
  popd
}

function clj {
  local cp=$CLOJURE_CLASSPATH
  local file
  if [[ $ARGC -eq 1 ]]; then
    file=$1
  elif [[ $ARGC -gt 1 ]]; then
    if [[ $1 == '-cp' ]]; then
      cp+=:$2
      file=$argv[3,-1]
    else
      file=$*
    fi
  fi
  if [[ -n $file ]]; then
    java -cp $cp $(echo $file | xargs)
  else
    java -cp $cp:$HOME/Java/lib/jline/jline.jar jline.ConsoleRunner clojure.main
  fi
}

function cljrb {
  rvm jruby
  local require_paths="`echo $CLOJURE_CLASSPATH | sed -E 's/(^|:)/ -r/g'`"
  if [[ $ARGC -eq 0 ]]; then
    irb `echo -n $require_paths | xargs`
  else
    ruby `echo -n $require_paths | xargs` $*
  fi
}

git_prompt_info() {
  local ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo ":%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%}"
  fi
}

function git_user_initials {
  local ref=$(git symbolic-ref HEAD 2> /dev/null)
  local inits
  if [[ -n $ref ]]; then
    inits=$(git config --get user.initials)
    if [[ -z $inits ]]; then inits="-solo-"; fi
    echo -n "($inits)"
  fi
}

project_name() {
  local name=$(pwd | awk -F/ '{print $NF}')
  echo $name
}

project_name_color() {
  local name=$(project_name)
  echo "%{\e[0;35m%}${name}%{\e[0m%}"
}

set_prompt() {
  export PROMPT=$'%{\e[0;36m%}%1/%{\e[0m%}'$(git_prompt_info)$(git_user_initials)'/ '
  # export RPROMPT="$(git_prompt_info)"
}

precmd() {
  set_prompt
}

function sc {
  if [ -f ./script/console ]; then
    ./script/console $@
  elif [ -f ./script/rails ]; then
    ./script/rails console $@
  else
    echo "This isn't a rails project!"
  fi
}

function ss {
  if [ -f ./script/server ]; then
    ./script/server $@
  elif [ -f ./script/rails ]; then
    ./script/rails server $@
  else
    echo "This isn't a rails project!"
  fi
}

function avr-man {
  command avr-man -M $HOME/local/share/man $@
}

# ALIASES
alias ls='ls -G'
alias ll='ls -hl'
alias tar='nocorrect /usr/bin/tar'
alias sudo='nocorrect sudo'
alias ri='ri -Tf ansi'
alias rtasks='rake --tasks'
alias sp='./script/spec -cfs'
alias makepasswd='makepasswd --count 5 --chars=8 --string='\''abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890%^&*()'\'
alias ff='open -a FireFox'
alias safari='open -a Safari'
alias gvim='mvim -p &> /dev/null'
alias gitdiff="git log|grep commit|awk '{print \$2}'|tail -n 2|xargs -n 2 git diff $1 $2|$EDITOR"
alias ngs="java -cp $CLOJURE_CLASSPATH:$HOME/Java/lib/vimclojure/build/vimclojure.jar:.:./classes com.martiansoftware.nailgun.NGServer 127.0.0.1"
alias ng=/Users/jon/Java/lib/vimclojure/ng
alias be="bundle exec"
alias emacs="emacs -nw"
alias rvmrc="source ./.rvmrc"

# rvm
if [[ -s $HOME/.rvm/scripts/rvm ]]; then
  source $HOME/.rvm/scripts/rvm
fi

# -- start rip config -- #
RIPDIR=/Users/jon/.rip
RUBYLIB="$RUBYLIB:$RIPDIR/active/lib"
PATH="$PATH:$RIPDIR/active/bin"
export RIPDIR RUBYLIB PATH
# -- end rip config -- #

if [ -f $HOME/.extrarc ]; then
  source $HOME/.extrarc
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
