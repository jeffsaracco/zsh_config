export DEFAULT_USER=`whoami`

# Path to your oh-my-zsh installation.
export ZSH=/Users/$DEFAULT_USER/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

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

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git bundler osx rake ruby brew capistrano common-aliases encode64 npm tmux)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --glob "!.git/*"'
export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"

fzf_git_log() {
    local commits=$(
      git ll --color=always "$@" |
        fzf --ansi --no-sort --height 100% \
            --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                       xargs -I@ sh -c 'git show --color=always @'"
      )
    if [[ -n $commits ]]; then
        local hashes=$(printf "$commits" | cut -d' ' -f2 | tr '\n' ' ')
        git show $hashes
    fi
}

alias gll='fzf_git_log'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias myip="ifconfig en0|awk '/inet / { print $2 }'"
alias rebasemaster='git fetch && git rebase origin/master || sadface'
alias rebaseorigin='git fetch && git rebase origin/`echo $(git symbolic-ref --short -q HEAD)` || sadface'
alias shutupvim='rm -rf /var/tmp/*.sw*'
alias speedtest='wget --delete-after http://cachefly.cachefly.net/10mb.test'
alias clr='clear'
alias cls='clear'
alias gitprune='git remote prune origin'
alias gitspec='bundle exec rspec `echo $(git st | grep _spec.rb | grep -v deleted | cut -f 2 -d "#" | cut -f 2 -d ":" | uniq)`'
alias gst='git status'
alias gut='git'
alias h='history | grep'
alias less='less -R'
alias rakeandbake='clear && rake'
alias sadface='(echo; echo "/-------\\"; echo "| *   * |"; echo "|  ___ ,|";  echo "| /   \\ |";  echo "\\-------/"; echo; false)'
alias work='cd ~/workspace'
alias testchanges='bin/tt $(git status --porcelain | grep test/ | awk \{print\ \$2\})'
alias gpr='hub pull-request -o'

alias ls='exa'
alias ll='ls -lagmh --all --git'
alias cat='bat'
alias ping='prettyping --nolegend'
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias top="sudo htop" # alias top and fix high sierra bug
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias help='tldr'
unalias fd

eval "$(hub alias -s)"

fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

fpath=(~/zsh_config/autoload $fpath)
autoload -Uz kp

export PGHOST=localhost

export NVM_DIR="/Users/$DEFAULT_USER/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin:
export PATH=$PATH:~/zsh_config/bin:
export PATH="$HOME/.cargo/bin:$PATH"
export GPG_TTY=$(tty)
eval "$(nodenv init -)"
eval "$(rbenv init -)"

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export PATH=$PATH:$PWD/bin

source ~/.bin/tmuxinator.zsh
export DISABLE_AUTO_TITLE=true

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="/usr/local/opt/go@1.13/bin:$PATH"
