export ARCHFLAGS='-arch x86_64'
export PATH=$HOME/.bin:$HOME/local/bin:$HOME/local/opt/gcc-arm-none-eabi/bin:/usr/local/bin:/usr/local/sbin:$PATH
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig"
export GREP_OPTIONS='--color=auto' 
export GREP_COLOR='3;33'
export EDITOR=vim
if [[ -z "$EMACS" ]]; then
    export TERM=xterm-256color
fi
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
export PGDATA=/usr/local/var/postgres
export WORDCHARS=
#export WORDCHARS=${WORDCHARS//[&=\/;!#%\{_-]}
export NODE_PATH=/usr/local/opt/node/lib
# For GO:
# export GOROOT=`brew --prefix go`/libexec
# export GOBIN=/usr/local/bin
# export GOARCH=amd64
# export GOOS=darwin
# export GOPATH=$HOME/go
# END: EXPORTS

# Chez Scheme
export SCHEMEHEAPDIRS="$HOME/local/lib/csv%v/%m"

# Chicken Scheme
export CHICKEN_INSTALL_PREFIX="$HOME/local"

# Java
# export JAVA_HOME="`/usr/libexec/java_home`"
# if [ "$JAVA_HOME" ]; then PATH="$PATH:$JAVA_HOME/bin"; fi

# For servicetown development
export SERVICETOWN_JAVA_OPTS="-Xms8G -Xmx8G -Xss1M -XX:MaxPermSize=1G -XX:ReservedCodeCacheSize=256M -XX:+UseCodeCacheFlushing -XX:+UseG1GC"

# AWS IAM
export AWS_IAM_HOME=/usr/local/opt/aws-iam-tools/libexec
export AWS_CREDENTIAL_FILE=$HOME/.aws-credentials-master

# CLANG WITH LIBCXX
# export CXX="clang++-3.3"
# export CXXFLAGS="-stdlib=libc++ -nostdinc++ -I/usr/local/lib/llvm-3.3/lib/c++/v1"
# export LDFLAGS="-L/usr/local/lib/llvm-3.3/usr/lib"

# Emacs key bindkings
bindkey -e


# HISTORY
HISTSIZE=10000
SAVEHIST=10000
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

# Git completion
zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash

# Force 'sudo zsh' to start root as a logging shell to avoid problems with environment clashes:
function sudo {
	if [[ $1 = "zsh" ]]; then
        command sudo /opt/local/bin/zsh -l
	else
        command sudo "$@"
	fi
}

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
  echo -n Restarting Rails server...
  if touch tmp/restart.txt 2> /dev/null; then
    echo
  else 
    echo 'FAILED!'
    echo Ensure you\'re at the root of a Rails project with a tmp/ directory.
  fi
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

function avr-man {
  command avr-man -M $HOME/local/share/man $@
pp}

function mandelbrot {
   local lines columns colour a b p q i pnew
   ((columns=COLUMNS-1, lines=LINES-1, colour=0))
   for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
       for ((a=-2.0; a<=1; a+=3.0/columns)) do
           for ((p=0.0, q=0.0, i=0; p*p+q*q < 4 && i < 32; i++)) do
               ((pnew=p*p-q*q+a, q=2*p*q+b, p=pnew))
           done
           ((colour=(i/4)%8))
            echo -n "\\e[4${colour}m "
        done
        echo
    done
}

# ALIASES
if [[ "`uname`" == Linux ]]; then
    alias ls='ls --color' 
else
    alias ls='ls -G'
fi
alias ll='ls -hl'
alias sudo='nocorrect sudo'
alias ri='ri -Tf ansi'
alias rtasks='rake --tasks'
alias sp='./script/spec -cfs'
alias makepasswd='makepasswd --count 5 --chars=8 --string='\''abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890%^&*()'\'
alias safari='open -a Safari'
alias gvim='mvim -p &> /dev/null'
alias gitdiff="git log|grep commit|awk '{print \$2}'|tail -n 2|xargs -n 2 git diff $1 $2|$EDITOR"
alias ngs="java -cp $CLOJURE_CLASSPATH:$HOME/Java/lib/vimclojure/build/vimclojure.jar:.:./classes com.martiansoftware.nailgun.NGServer 127.0.0.1"
alias ng=/Users/jon/Java/lib/vimclojure/ng
alias be="bundle exec"
alias bi="bundle install"
alias emacs="emacs -nw"
alias rc="./script/rails console"
alias rs="./script/rails server"
alias rdb="./script/rails dbconsole"

alias jl="rlwrap -a JLinkExe"
alias jlg=JLinkGDBServer

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Cabal
export PATH="$HOME/.cabal/bin:/opt/cabal/1.20/bin:/opt/ghc/7.10.1/bin:$PATH"

if [ -f $HOME/.extrarc ]; then
  source $HOME/.extrarc
fi

ssh-add $HOME/.ssh/id_dsa > /dev/null 2>&1 # Add id_rsa key
