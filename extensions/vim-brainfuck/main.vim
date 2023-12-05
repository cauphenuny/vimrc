autocmd BufNewFile,BufRead *.bf,*.brainfuck set filetype=brainfuck

let plugin_dir = g:vim_conf_dir . 'extensions/vim-brainfuck/'

autocmd FileType brainfuck execute 'source ' . plugin_dir . 'indent.vim'
autocmd FileType brainfuck execute 'source ' . plugin_dir . 'syntax.vim'
