# START: EXPORTS
export ARCHFLAGS='-arch i386'
export PATH=/Library/Ruby/bin:/opt/local/bin:/Library/PostgreSQL8/bin:/opt/local/sbin:/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/:$PATH
export PATH=/opt/local/lib/postgresql83/bin:$PATH
export PATH=$PATH:/usr/local/mongodb/bin
export GREP_OPTIONS='--color=auto' 
export GREP_COLOR='3;33'
export GEM_HOME=/Library/Ruby/Gems/1.8
export EDITOR='vim'
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

export PS1='%{$reset_color$fg[cyan]%}%2~%{$reset_color$bold_color$fg[green]%}%{$reset_color$fg[green]%}$(parse_git_branch)$(parse_svn_branch)>%{$reset_color%} '
###########################################
#   iTerm Tab and Title Customization     #
###########################################

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\/git:\1/'
}
parse_svn_branch() {
  parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "/svn:"$1 $2 ""}'
}
parse_svn_url() {
  svn info 2>/dev/null | grep -e '^URL*' | sed -e 's#^URL: *\(.*\)#\1#g '
}
parse_svn_repository_root() {
  svn info 2>/dev/null | grep -e '^Repository Root:*' | sed -e 's#^Repository Root: *\(.*\)#\1\/#g '
}

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

function vack {
  mvim -p $(ack -l $@ | xargs) &> /dev/null &
}
     
function reload! {
  echo Restarting passenger...
  touch tmp/restart.txt
}

# ALIASES
alias ocaml="rlwrap ocaml"
alias ssh='/usr/bin/ssh'
alias ls='ls -G'
alias ll='ls -hl'
alias tar='nocorrect /usr/bin/tar'
alias sudo='nocorrect sudo'
alias rmate='mate app config doc db lib public script spec test stories liquid'
alias ri='ri -Tf ansi'
alias rtasks='rake --tasks'
alias sp='./script/spec -cfs'
alias ss='./script/server'
alias sc='./script/console'
alias cruise='svn up; rake cruise'
alias vi='/opt/local/bin/vim'
alias postgres_start='pg_ctl -D ~/.pgdata -l ~/.pgdata/psql.log start'
alias vim='/opt/local/bin/vim -p'
alias postgres_stop='pg_ctl -D ~/.pgdata stop'
alias mysql='/opt/local/bin/mysql5 -u root --socket=/tmp/mysql.sock'
alias mysqladmin='/opt/local/bin/mysqladmin5 -u root --socket=/tmp/mysql.sock'
alias makepasswd='makepasswd --count 5 --chars=8 --string='\''abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890%^&*()'\'

function push_configs {
  pushd
  cd ~/projects/configs
  git add .
  git ci 
  git push
  popd
}

function mysqlredo {
  mysqladmin drop $@
  mysqladmin create $@
  mysql $@
}

alias ff='open -a FireFox'
alias safari='open -a Safari'
alias gvim='mvim -p &> /dev/null'
alias gitdiff="git log|grep commit|awk '{print \$2}'|tail -n 2|xargs -n 2 git diff $1 $2|$EDITOR"

bindkey '^K' kill-whole-line
bindkey "^R" history-incremental-search-backward
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^J" self-insert

git_prompt_info () {
 ref=$(git symbolic-ref HEAD 2> /dev/null) || return
 echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
}

project_name () {
  name=$(pwd | awk -F'projects/' '{print $2}' | awk -F/ '{print $1}')
  echo $name
}

project_name_color () {
  name=$(project_name)
  echo "%{\e[0;35m%}${name}%{\e[0m%}"
}

export PROMPT=$'%{\e[0;36m%}%1/%{\e[0m%}/ '
set_prompt () {
  export RPROMPT="$(project_name_color)$(git_prompt_info)"
}

set_term_title() {
  title=`ruby -e "
    path = \"$PWD\"
    until path.length <= 50 || path =~ /(\/[^\/])+(?=\/[^\/]+$)/ || path =~ /^\/[^\/]+$/
      path.sub!(/(\/[^\/])[^\/]+(?=\/[^\/]+)/, '\1')
    end
    puts path
  "`
  echo -n "\e];$title\a"
}

precmd() {
  set_term_title
  set_prompt
}

function native_gems {
  ruby -e 'puts(Dir["/Library/Ruby/Gems/1.8/gems/**/*.{so,bundle}"].map do |f| 
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

# -- start rip config -- #
RIPDIR=/Users/jon/.rip
RUBYLIB="$RUBYLIB:$RIPDIR/active/lib"
PATH="$PATH:$RIPDIR/active/bin"
export RIPDIR RUBYLIB PATH
# -- end rip config -- #
