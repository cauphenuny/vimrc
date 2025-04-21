#fzf

source <(fzf --zsh)

# Scheme name: Gruvbox Material Dark, Medium
# Scheme system: base16
# Scheme author: Mayush Kumar (https://github.com/MayushKumar), sainnhe (https://github.com/sainnhe/gruvbox-material-vscode)
# Template author: Tinted Theming (https://github.com/tinted-theming)

_gen_fzf_default_opts() {

local color00='#292828'
local color01='#32302f'
local color02='#504945'
local color03='#665c54'
local color04='#ebdbb2'
local color05='#ddc7a1'
local color06='#ebdbb2'
local color07='#fbf1c7'
local color08='#ea6962'
local color09='#e78a4e'
local color0A='#d8a657'
local color0B='#a9b665'
local color0C='#89b482'
local color0D='#7daea3'
local color0E='#d3869b'
local color0F='#bd6f3e'

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:$color01,spinner:$color0C,hl:$color0D"\
" --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"\
" --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

}

_gen_fzf_default_opts

fzfpreview() {
    if [ $(tput cols) -lt 120 ]; then
        opt=""
    else
        opt="-lh"
    fi
    fzf --height 70% --reverse \
        --preview "\
            [ -f {} ] && \
                eza --color=always $opt {} && \
                echo \"\n\e[4mPreview$reset_color\" && \
                bat --color=always --theme 'Gruvbox Flat Dark' --style=numbers --line-range=:500 {} \
            || [ -d {} ] && \
                eza -T --level=1 --color=always $opt {} \
            || echo {} | awk '{print \$1}' | xargs tldr --color;\
            "\
        --preview-window=right:60%
}

f() {
    if [ -n "$1" ]; then
        cmd=$1
        shift
    else
        cmd=""
    fi
    file=$(find "${@:-.}" | fzfpreview)
    if [ -s "$file" ] && [ -n "$cmd" ]; then
        echo "$cmd $file"
        eval "$cmd" \"$file\"
    fi
}

alias fop="f open"
alias fvi="f vim"
alias fco="f code"
alias fcl="f clion"
fcd(){
    eval f cd ${@:-.} -type d 
}

fhistory() {
    cmd=$(history | awk '{$1=""; print $0}' | tac | fzfpreview)
    if [ -n "$cmd" ]; then
        echo '$'$cmd
        printf "exec? "
        read ch
        if [ "$ch" = "y" ]; then
            eval "$cmd"
        fi
    fi
}
alias fhis=fhistory

fj() {
    dir=$(autojump -s | awk '/^-*$/{exit} {print $2}' | tac | fzfpreview)
    cmd=${@:-cd}
    if [ -d "$dir" ]; then
        echo $cmd "$dir"
        eval $cmd "$dir"
    elif [ -n "$dir" ]; then
        echo "No such directory: $dir"
        autojump --purge
        return 1
    fi
}
