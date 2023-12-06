autocmd BufNewFile,BufRead *.bf,*.brainfuck set filetype=brainfuck

autocmd FileType brainfuck execute 'source ~/.vim/extensions/indent.vim'
autocmd FileType brainfuck execute 'source ~/.vim/extensions/syntax.vim'
