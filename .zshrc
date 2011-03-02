# START: EXPORTS
export ARCHFLAGS='-arch x86_64'
PATH=$HOME/.bin:$HOME/.gem/ruby/1.8/bin:/usr/local/bin:/usr/local/sbin:$PATH
export PATH
export GREP_OPTIONS='--color=auto' 
export GREP_COLOR='3;33'
export GEM_HOME=~/.gem/ruby/1.8
export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
export TERM=xterm-color
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
export GRADLE_HOME=/opt/local/share/java/gradle
export ACTIVEMQ_HOME=/usr/local/apache-activemq
export JAVA_HOME=/Library/Java/Home
export PGDATA=/usr/local/var/postgres
# For GO:
export GOROOT=`brew --prefix go`
export GOBIN=/usr/local/bin
export GOARCH=amd64
export GOOS=darwin
# END: EXPORTS

# START RAKE COMPLETION (caching rake tasks per project directory, not globally)
function _rake_does_task_list_need_generating () {
  if [ ! -f .zsh_rake_cache ]; then
    return 0;
  else
    accurate=$(stat -f%m .zsh_rake_cache)
    changed=$(stat -f%m Rakefile)
    return $(expr $accurate '>=' $changed)
  fi
}

function _rake () {
  if [ -f Rakefile ]; then
    if _rake_does_task_list_need_generating; then
      echo "\nGenerating zsh rake cache..." > /dev/stderr
      rake --silent --tasks | cut -d " " -f 2 > .zsh_rake_cache
    fi
    reply=( `cat .zsh_rake_cache` )
  fi
}
compctl -K _rake rake
# ENDING RAKE COMPLETION

# color module
autoload colors ; colors	

# Keeps the paths from growing too big    
typeset -U path manpath fpath

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

# COMPLETION
zmodload -i zsh/complist
zstyle ':completion:*' menu select=10
zstyle ':completion:*' verbose yes

# Completing process IDs with menu selection:
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

# Prevent CVS/SVN files/directories from being completed:
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)SVN'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#SVN'

## With commands like `rm' it's annoying if one gets offered the same filename
## again even if it is already on the command line. To avoid that:
zstyle ':completion:*:rm:*' ignore-line yes

# Force 'sudo zsh' to start root as a logging shell to avoid problems with environment clashes:
function sudo {
	if [[ $1 = "zsh" ]]; then
        command sudo /opt/local/bin/zsh -l
	else
        command sudo "$@"
	fi
}

function brew {
  if [[ $1 == "upgrade" ]]; then
    command brew update
    echo Upgrading the following packages: `brew outdated`
    for recipe in $(brew outdated | awk '{print $1}'); do
      command brew rm $recipe
      command brew install $recipe
    done
  else
    command brew $*
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

# set_term_title() {
#   local title=`system_ruby -e "
#     path = \\"$PWD\\"
#     until path.length <= 50 || path =~ /(\\/[^\\/])+(?=\\/[^\\/]+$)/ || path =~ /^\\/[^\\/]+$/
#       path.sub!(/(\\/[^\\/])[^\\/]+(?=\\/[^\\/]+)/, '\\2')
#     end
#     puts path
#   "`
#   echo -n "\\e];$title\\a"
# }

precmd() {
  # set_term_title
  set_prompt
}

function native_gems {
  system_ruby -e 'puts(Dir["/Library/Ruby/Gems/1.8/gems/**/*.{so,bundle}"].map do |f| 
                     f.split("/")[6].gsub(/([\w-]+)-((?:\d+\.)+\d+)/, "\\1 (\\2)")
                   end.uniq)'
}

function rebuild_gems {
  if [[ $1 = '--all' ]]; then
    echo "Rebuilding all gems..."
    gem list | awk '{print $1}' | xargs sudo gem install
  else
    echo "Rebuilding gems with native extensions..."
    native_gems | awk '{print $1}' | xargs sudo gem install
  fi
}

function sc {
  if [ -f ./script/console ]; then
    ./script/console $*
  elif [ -f ./script/rails ]; then
    ./script/rails console $*
  else
    echo "This isn't a rails project!"
  fi
}

function ss {
  if [ -f ./script/server ]; then
    ./script/server $*
  elif [ -f ./script/rails ]; then
    ./script/rails server $*
  else
    echo "This isn't a rails project!"
  fi
}

# ALIASES
alias ls='ls -G'
alias ll='ls -hl'
alias tar='nocorrect /usr/bin/tar'
alias sudo='nocorrect sudo'
alias ri='ri -Tf ansi'
alias rtasks='rake --tasks'
alias sp='./script/spec -cfs'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim -p'
alias makepasswd='makepasswd --count 5 --chars=8 --string='\''abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890%^&*()'\'
alias ff='open -a FireFox'
alias safari='open -a Safari'
alias gvim='mvim -p &> /dev/null'
alias gitdiff="git log|grep commit|awk '{print \$2}'|tail -n 2|xargs -n 2 git diff $1 $2|$EDITOR"
alias ngs="java -cp $CLOJURE_CLASSPATH:$HOME/Java/lib/vimclojure/build/vimclojure.jar:.:./classes com.martiansoftware.nailgun.NGServer 127.0.0.1"
alias ng=/Users/jon/Java/lib/vimclojure/ng
alias be="bundle exec"
alias system_ruby=/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/bin/ruby
alias emacs="emacs -nw"
alias e="open -a Emacs"

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
