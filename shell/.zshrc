# Detect OS first, at the very top
case "$(uname -s)" in
  Darwin) export IS_MAC=true ;;
  Linux)  export IS_LINUX=true ;;
esac


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"
# Fix Kitty keyboard protocol in Ghostty
if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
  DISABLE_MAGIC_FUNCTIONS=true
fi

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ruby mise gem sublime npm yarn heroku kubectl kubectx kube-ps1)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# rbenv
# eval "$(rbenv init - zsh)"

# --- Homebrew ---
# Only run on Mac, silently skipped on Linux
if [[ "$IS_MAC" == true ]]; then
  # Apple Silicon path (adjust if you're on Intel: /usr/local)
  export PATH="/opt/homebrew/bin:$PATH"
  eval "$(brew shellenv)"

  # install older ruby version on M1
  # https://stackoverflow.com/questions/69012676/install-older-ruby-versions-on-a-m1-macbook
  # export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
  # Oct 2024 updated to openssl 3 as 1.1 has become deprecated
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"
  # export LDFLAGS="-L/opt/homebrew/opt/readline/lib:$LDFLAGS"
  # export CPPFLAGS="-I/opt/homebrew/opt/readline/include:$CPPFLAGS"
  # export PKG_CONFIG_PATH="/opt/homebrew/opt/readline/lib/pkgconfig:$PKG_CONFIG_PATH"
  export optflags="-Wno-error=implicit-function-declaration"
  # export LDFLAGS="-L/opt/homebrew/opt/libffi/lib:$LDFLAGS"
  # export CPPFLAGS="-I/opt/homebrew/opt/libffi/include:$CPPFLAGS"
  # export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig:$PKG_CONFIG_PATH"

  # subl command
  export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

  # python/pip 3 doesn't default
  alias python=/opt/homebrew/bin/python3
  alias pip=/opt/homebrew/bin/pip3

  # sourcetree CLI
  alias stree='/Applications/SourceTree.app/Contents/Resources/stree'

  alias fix_camera="sudo killall VDCAssistant"
  alias prepareubmprod='az aks get-credentials --resource-group created-by-SfG --name aks-prod --overwrite-existing && kubelogin convert-kubeconfig -l azurecli'
  alias ubmprodconsole="prepareubmprod && kubectl exec -it deploy/ubm-web -- bash -c 'RAILS_ENV=production RAILS_MASTER_KEY=$(</mnt/secrets/RAILS-MASTER-KEY) rails console'"


  # Commit Change
  alias cc-run='bin/cc-run'
  alias ccr='bin/cc-run'

  # EdFuel
  alias ef-run='/Users/jared/Documents/code/edfuel-talenthub/run'
  alias efrun='/Users/jared/Documents/code/edfuel-talenthub/run'

  # The following lines have been added by Docker Desktop to enable Docker CLI completions.
  fpath=(/Users/jared/.docker/completions $fpath)
  autoload -Uz compinit
  compinit
  # End of Docker CLI completions
  export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
fi


# Enable yjit for all uses of Ruby
export RUBYOPT="--yjit"
# jemalloc config
export MALLOC_CONF="dirty_decay_ms:1000,narenas:2,background_thread:true"

# nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh" 2>/dev/null  # This loads nvm
# [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# subl command
export EDITOR='subl -w'

# custom aliases
alias flushdns='dscacheutil -flushcache'
alias sclear='clear && clear'
alias bup='bundle update'
alias bx='bundle exec'
alias bexec_u_rails='bundle exec unicorn_rails'
alias dc='docker-compose'


# Rails configuration
# disable spring for older applications
export DISABLE_SPRING=true

# activate mise
eval "$(mise activate zsh)"
