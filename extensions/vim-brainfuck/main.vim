autocmd BufNewFile,BufRead *.bf,*.brainfuck set filetype=brainfuck

autocmd FileType brainfuck execute 'source ~/.vim/extensions/vim-brainfuck/indent.vim'
autocmd FileType brainfuck execute 'source ~/.vim/extensions/vim-brainfuck/syntax.vim'
