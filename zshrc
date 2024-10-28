# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="hydropek" # set by `omz`

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
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

MODE_CURSOR_VIINS="#00ffff blinking bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
MODE_CURSOR_VICMD="green blinking block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"
# MODE_INDICATOR_VIINS='%F{8}[INSERT]%f'
MODE_INDICATOR_VIINS=''
MODE_INDICATOR_VICMD='%F{10}[NORMAL]%f'
MODE_INDICATOR_REPLACE='%F{9}[REPLACE]%f'
MODE_INDICATOR_SEARCH='%F{13}[SEARCH]%f'
MODE_INDICATOR_VISUAL='%F{12}[VISUAL]%f'
MODE_INDICATOR_VLINE='%F{12}[V-LINE]%f'
RPS1="${MODE_INDICATOR_PROMPT} $RPS1"


# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# autojump
[ -f $HOMEBREW_PREFIX/etc/profile.d/autojump.sh ] && . $HOMEBREW_PREFIX/etc/profile.d/autojump.sh

# Compilation flags
export ARCHFLAGS="-arch x86_64"
CPPCOMPILER="clang++"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias clang-apple='/usr/bin/clang'
alias clang++-apple='/usr/bin/clang++'
gxx="g++-14"
cxx="clang++"

alias g++="${gxx}"
alias c++="${cxx}"
alias g++11="${gxx} -std=c++11"
alias g++14="${gxx} -std=c++14"
alias g++17="${gxx} -std=c++17"
alias g++20="${gxx} -std=c++20"
alias g++23="${gxx} -std=c++2b"
alias c++11="${cxx} -std=c++11"
alias c++14="${cxx} -std=c++14"
alias c++17="${cxx} -std=c++17"
alias c++20="${cxx} -std=c++20"
alias c++23="${cxx} -std=c++23"

alias dcp="docker cp"
alias storage="du -sh * . | sort -h"

autoload -U colors && colors
export CLICOLOR=1

# env var setting

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH="$(find /opt/homebrew/Cellar -name 'pkgconfig' -type d -maxdepth 4 | grep lib/pkgconfig | tr '\n' ':' | sed s/.$//):$PKG_CONFIG_PATH"

path=('/usr/local/bin' $path)
typeset -U path
export PATH

# other functions

function proxy() {
    if (( $# == 0 )); then
        echo "HTTP proxy: $http_proxy"
        return 0
    fi

    case $1 in
    "v2ray")
        export http_proxy="http://127.0.0.1:8889"
        export https_proxy=$http_proxy
        export ALL_PROXY="socks5://127.0.0.1:1089"
        echo "HTTP Proxy enabled $http_proxy \e[2m(v2ray)$reset_color"
        ;;
    "clash")
        export http_proxy="http://127.0.0.1:7890"
        export https_proxy=$http_proxy
        export ALL_PROXY="socks5://127.0.0.1:7891"
        echo "HTTP Proxy enabled $http_proxy \e[2m(clash)$reset_color"
        ;;
    "off")
        unset http_proxy
        unset https_proxy
        unset ALL_PROXY
        echo "HTTP Proxy $fg[red]disabled$reset_color"
        ;;
    *)
        echo "proxy v2ray/clash/off/(null)"
        return 1
    esac
}

proxy clash

function today() {
    date_dir=`date +"20%y/%m/%d"`
    src_dir="$HOME/Source/"
    full_dir="$src_dir$date_dir"
    if ! [ -d $full_dir ]; then
        mkdir -p $full_dir
    fi
    cd $full_dir
}

function tempdir_d() {
    dir=$HOME/Temporary/daily
    if ! [ -d $dir ]; then
        mkdir $dir
    fi
    cd $dir
}
function tempdir_w() {
    dir=$HOME/Temporary/weekly
    if ! [ -d $dir ]; then
        mkdir $dir
    fi
    cd $dir
}
alias tempdir=tempdir_d

function transay() {
    trans -s en -t zh $1
    say $1
}

function ext() {
    (
        export PATH="/Volumes/2T-SSD/bin:$PATH"
        $@
    )
}

export hexo_path="$HOME/Documents/Blog/data.cauphenuny.github.io"
hexo-util() {
    cur_path=$(pwd);
    builtin cd $hexo_path
    if ! [ $# -lt 1 ]; then
        if [ -x $hexo_path/source/tools/$1 ]; then
            $hexo_path/source/tools/$*
        else
            hexo $argv
        fi
        builtin cd $cur_path
    fi
}
alias h=hexo-util

alias rm="/usr/local/bin/trash"

eval $(thefuck --alias)

# pnpm
export PNPM_HOME="/Users/ycp/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

source ~/.bash_profile

export LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++"

#fzf

source <(fzf --zsh)

fvim() {
    file=$(
        find "${@:-.}"\
      | fzf --height 70% --reverse \
            --preview "eza -T --level=1 --color=always -lh {}; if [ -f {} ]; then echo \"\n\e[4mPreview$reset_color\" && bat --color=always --style=numbers --line-range=:500 {}; fi" \
            --preview-window=right:60%
    )
    if [ -n "$file" ]; then
        vim "$file"
    fi
}

fop() {
    file=$(
        find "${@:-.}" \
      | fzf --height 70% --reverse \
            --preview "eza -T --level=1 --color=always -lh {}; if [ -f {} ]; then echo \"\n\e[4mPreview$reset_color\" && bat --color=always --style=numbers --line-range=:500 {}; fi" \
            --preview-window=right:60%
    )
    if [ -n "$file" ]; then
        echo "select: $file"
        printf "command: "
        read cmd
        echo "exec:" $cmd "$file"
        $cmd "$file"
    fi
}

fj() {
    dir=$(
        find "${@:-.}" -type d \
      | fzf --height 70% --reverse \
            --preview "eza -T --level=1 --color=always -lh {}; if [ -f {} ]; then echo \"\n\e[4mPreview$reset_color\" && bat --color=always --style=numbers --line-range=:500 {}; fi" \
            --preview-window=right:60%
    )
    if [ -d $dir ]; then
        echo "jump to $dir"
        cd "$dir"
    else
        echo "not a directory: $dir"
    fi
}

fhis() {
    cmd=$(
        history \
        | fzf --height 70% --reverse --tac \
        | awk '{$1=""; print $0}'
    )
    if [ -n "$cmd" ]; then
        echo $cmd
    fi
}
