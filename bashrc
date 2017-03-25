# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH="$PATH:$HOME/.rvm/bin:$HOME/projetos/daileon"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.

#######################
######################
#######################

# User specific aliases and functions
alias lalias='cat ~/.bashrc | grep alias'
alias ll='ls -laGh --color=auto'
alias ls='ls -FG --color=always'
alias c='clear'
alias ..='cd ..'
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'


#GIT
# git completion
source /etc/bash_completion.d/git-completion.bash

# git branch
parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

PS1="\$(parse_git_branch)$PS1"

#git alias
## Pretty graph
alias gl='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit --'
alias glmd='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit origin/master..origin/dev'
## Pretty graph one parent
alias gl1p='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit --first-parent'
alias glfh='git log --graph --full-history --all --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit --'
alias git_tags_with_dates='git log --tags --simplify-by-decoration --pretty="format:%ai %d"'

dirtree() {
	ls $1 -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/';
}

# Found in
# http://code-and-hacks.peculier.com/vim/recovering-after-vim-terminates/
function vimswp (){
       swap_files=`find . -name "*.swp"`

       for s in $swap_files ; do
               orig_file=`echo $s | perl -pe 's!/\.([^/]*).swp$!/$1!' `
               echo "Editing $orig_file"
               sleep 1
               vim -r $orig_file -c "DiffOrig"
               echo -n "  Ok to delete swap file? [y/n] "
               read resp
               if [ "$resp" == "y" ] ; then
                       echo "  Deleting $s"
                       rm $s
               fi
       done
}


export TERM='xterm-256color'

alias solr-restart='sudo /opt/solr-5.3.2_ev-0.3/solr-5.3.2-SNAPSHOT/bin/solr restart -Dsolr.solr.home=/home/bmentges/projetos/opsworks-cookbooks/solr-config/files/default/'
alias evtunnel-dev='ssh -f bmentges@dev2.virtualshelf.net -L 9000:localhost:3306 -N'
alias tunnel='kill `ps aux | grep "ssh -f bmentges@dev2.virtualshelf.net -L 3307:127.0.0.1:3306 -N" | awk "{print $2}"`'
alias dss='function _dss { cd /home/bmentges/projetos/daileon;/home/bmentges/projetos/daileon/daileon.rb show "$1"; cd -; }; _dss'
alias dsp='function _dsp { cd /home/bmentges/projetos/daileon;/home/bmentges/projetos/daileon/daileon.rb -e prod show "$1"; cd -; }; _dsp'
alias gtag='git tag $(date +"%Y_%m_%d_%H_%M_%S") '
alias branch='for k in `git branch | perl -pe s/^..//`; do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k -- | head -n 1`\\t$k; done | sort -r'
alias dc='docker-compose'
alias be='bundle exec'
alias reload_tags='.git/hooks/ctags'
alias lib='cd ~/projetos/library'

function pp_curl {
   curl $1 | python -m json.tool | less
 }

function port {
  sudo netstat -tulpn | grep ":$1"
}

function watchy {
  inotifywait -q -m -e close_write -r ./ |
  while read events; do
    zeus rspec $1;
  done
}

function daileon {
  pushd ~/projetos/daileon;
  ./daileon.rb $@;
  popd;
}

function pdaileon {
  pushd ~/projetos/daileon;
  ./daileon.rb -e prod $@;
  popd;
}

function rename_workspaces {
  i3-msg '
    rename workspace 1 to 1:browser;
    rename workspace 2 to 2:slack;
    rename workspace 3 to 3:monitoring;
    rename workspace 4 to 4z:vim;
    rename workspace 5 to 5x:exec;
    rename workspace 6 to 6c:prod;
  '
}

function confirm {                                                                                   
  read -r -p "${1:-Are you sure?} [Y/n] " response                                                   
  if [[ "$response" =~ ^([yY]([eE][sS])?|)$ ]]                                                       
  then                                                                                               
    true                                                                                             
  else                                                                                               
    false                                                                                            
  fi                                                                                                 
}                                                                                                    
                                                                                                     
function pdeploy {                                                                                   
  pushd ~/projetos/$1                                                                                     
  curr_branch=$(parse_git_branch)                                                                    
  git stash && git co master && git pull && git diff ...origin/dev
  confirm "Deploy branch master to $1 in prod?" && git merge origin/dev && git push && daileon -e prod deploy $1
  git co "$curr_branch"                                                                              
  git stash pop                                                                                      
  popd                                                                                               
}    

source ~/.bashrc_private

export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig:$PKG_CONFIG_PATH"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export JAVA_HOME="/usr/lib/jvm/java-8-oracle"
export JRE_HOME="/usr/lib/jvm/java-8-oracle/jre"
