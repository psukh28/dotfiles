if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 5 

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"


# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

zstyle :omz:plugins:iterm2 shell-integration yes

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$ZSH/custom

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search gcloud macos tmux zsh-interactive-cd )

source $ZSH/oh-my-zsh.sh

# User configuration


# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

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
alias zshconfig="nvim ~/.zshrc" 
alias cht='~/.dotfiles/cht.sh'


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pranavsukumaran/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/pranavsukumaran/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/pranavsukumaran/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/pranavsukumaran/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export PATH=$PATH:~/.local/bin
export PATH="/opt/homebrew/bin:$PATH"
# git commands
alias -g g=git
alias -g gbl='branch -a'
alias -g gcl='git clone '
alias -g pp='git pull --rebase && git push'
alias -g gpr='git pull-request -b '
alias -g ga='git add .'
alias -g gc='git commit -m '
alias -g gagc='git add . && git commit -m '
alias -g gbr='git browse'
alias -g grb='git rebase -'
alias -g gs='git status'
alias -g gb='git checkout -b'
alias -g grc='git rebase --continue'
alias -g grs='git rebase --skip'
alias -g grv='git remote -v'
alias -g gp='git fetch -p'

alias netflix='open https://mv-web.netlify.app'
alias csv='csv.sh'
alias spotify='/Users/pranavsukumaran/spotify-player/target/debug/spotify_player'
eval "$(zoxide init --cmd cd zsh)"
export PATH="/Users/pranavsukumaran/Desktop/Personal_dev/csv_viewer:$PATH"
export PATH="/Users/pranavsukumaran/spotify-player/target/debug:$PATH"
export PATH="$PATH:$(npm config get prefix)/bin"
eval "$(fzf --zsh)"


eval "$(direnv hook zsh)"

# -- fzf theme --
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --color=fg:-1,bg:-1,hl:#5f87af \
  --color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff \
  --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff \
  --color=marker:#87ff00,spinner:#af5fff,header:#87afaf \
  --border=rounded --border-label='Result:' --border-label-pos=2 --preview-window='border-rounded' \
  --padding=0 --prompt='> ' --marker='>' --pointer='◆' \
  --separator='─' --scrollbar='│' \
  --preview-window 'right:50%'"
# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}


source ~/fzf-git.sh/fzf-git.sh

# --- eza ---
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# --- taskwarrior-tui
alias tasks='taskwarrior-tui'
# --- previews with fzf ---

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"


POWERLEVEL9K_TRANSIENT_PROMPT=always
