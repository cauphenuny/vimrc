# PROMPT='%{${fg[gray]}%}%n:%{$reset_color%}%{${fg_bold[blue]}%}%3~%{${reset_color}%} $(git_prompt_info)%(?:%{$fg_bold[gray]%}➜:%{$fg_bold[red]%}➜)%{${reset_color}%} '
PROMPT='%{$fg_bold[gray]%}»%{$reset_color%} %{$reset_color%}%{${fg_bold[blue]}%}%3~%{${reset_color}%} $(git_prompt_info)%(?:%{$fg_bold[gray]%}➜:%{$fg_bold[red]%}➜)%{${reset_color}%} '

# local return_code="%(?.%{$fg[gray]%}.%{$fg[red]%}[%?] )%*%{$reset_color%}"
# RPS1="${return_code}"

# right prompt: return code, virtualenv and context (user@host)
RPS1="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
if (( $+functions[virtualenv_prompt_info] )); then
  RPS1+='$(virtualenv_prompt_info)'
fi
# RPS1+=" %{${fg[gray]}%}%n@%m%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%{$reset_color%} "
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}› ${$fg_bold[red]%}✗"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%}›✔"

