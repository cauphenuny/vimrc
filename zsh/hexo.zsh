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
