" ---------------------- Global settings -----------------------
set number
set ruler
set showcmd
set mouse=a
set cursorline
"set cursorcolumn
set nocompatible

set expandtab
autocmd FileType make set noexpandtab
set smarttab
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

set autochdir
set autowrite
set autoread
set hlsearch
set incsearch


" ---------------------- Theme and Colors ----------------------
syntax on
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_contrast_light = 'soft'
let g:gruvbox_transp_bg = 1
set laststatus=2
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'gruvbox8',
  \ }
colorscheme gruvbox8

" ---------------------- Compile and Run  ----------------------

" C Compiling Options (variable in certain buffer)
let b:cc = {
\   'opts': ['-Wall', '-Wextra', '-Wshadow'],
\   'pkgs': [],
\}

autocmd Filetype cpp {
    b:cc.compiler = 'clang++'
    b:cc.std = 'c++17'
}

autocmd Filetype c {
    b:cc.compiler = 'clang'
    b:cc.std = 'c99'
}

let g:ccenv_dir = expand('~/.vim/cache/ccenv/')

func! CCSetUp()
    if !isdirectory(g:ccenv_dir)
        call system('mkdir -p '.g:ccenv_dir)
    endif
endfunc

func! CCClear()
    call system('rm '.g:ccenv_dir.'*')
endfunc

autocmd FileType c,cpp call CCSetUp()

func! SaveOption()
    let name = split(system('echo '.expand('%:p').' | md5sum'))[0]
    let file = g:ccenv_dir . name
    call system('touch '.file)
    let info = b:cc.compiler . ' ' . b:cc.std . '\n' . join(b:cc.opts).'\n'.join(b:cc.pkgs)
    call system('echo "'.info.'" > '.file)
endfunc

func! ReadOption()
    let name = split(system('echo '.expand('%:p').' | md5sum'))[0]
    let file = g:ccenv_dir . name
    if filereadable(file)
        let lines = readfile(file)
        let basic = split(lines[0])
        let b:cc.opts = split(lines[1])
        let b:cc.pkgs = split(lines[2])
        let b:cc.compiler = basic[0]
        let b:cc.std = basic[1]
    endif
endfunc

autocmd FileType c,cpp call ReadOption()

func! OptOn(opt)
    let idx = index(b:cc.opts, a:opt)
    if idx == -1
        call add(b:cc.opts, a:opt)
        call SaveOption()
    endif
endfunc

func! OptOff(opt)
    let idx = index(b:cc.opts, a:opt)
    if idx != -1
        call remove(b:cc.opts, idx)
        call SaveOption()
    endif
endfunc

func! OptSwitch(opt)
    let idx = index(b:cc.opts, a:opt)
    if idx == -1
        call add(b:cc.opts, a:opt)
    else
        call remove(b:cc.opts, idx)
    endif
    call SaveOption()
endfunc

func! PkgLink(pkg)
    let idx = index(b:cc.pkgs, a:pkg)
    if idx == -1
        call add(b:cc.pkgs, a:pkg)
    else
        call remove(b:cc.pkgs, idx)
    endif
    call SaveOption()
endfunc

func! SetCompiler(cpl)
    let b:cc.compiler = a:cpl
    call SaveOption()
endfunc

func! SetStd(std)
    let b:cc.std = a:std
    call SaveOption()
endfunc

func! MemDebug()
    call OptSwitch('-fsanitize=undefined,address,leak,null,bounds')
    call OptSwitch('-fno-omit-frame-pointer')
endfunc

func! EchoRun(cmd)
    if a:cmd != ''
        exec '!echo '.a:cmd.' && '.a:cmd
    else
        echo 'Invalid command.'
    endif
endfunc

func! GetCompileOption()
    let opts = join(b:cc.opts)
    for pkg in b:cc.pkgs
        let opts .= ' $(pkg-config --cflags --libs '.pkg.')'
    endfor
    return opts
endfunc

func! Compile()
    if &modified
        exec 'w'
    endif
    if &filetype == 'cpp' || &filetype == 'c'
        if filereadable(expand("./Makefile"))
            call EchoRun('make')
        else
            call EchoRun(b:cc.compiler.' % -o %< -std='.b:cc.std.' '.GetCompileOption())
        endif
    elseif &filetype == 'haskell'
        call EchoRun('ghc %')
    else
        echo 'Can not compile this file.'
        return
    endif
endfunc

func! GetRunCommand()
    if &filetype == 'cpp' || &filetype == 'c'
        if filereadable(expand("./Makefile"))
            return 'make run'
        else
            return 'time ./%<'
        endif
    elseif &filetype == 'haskell'
        return 'time ./%<'
    elseif &filetype == 'python'
        return 'time python3 %'
    elseif &filetype == 'sh'
        return 'zsh %'
    endif
endfunc

map <F9> :call Compile()<CR>
imap <F9> <ESC><F9>

map <F10> :call EchoRun(GetRunCommand())<CR>
imap <F10> <ESC><F10>

map <S-F10> :call EchoRun(GetRunCommand() . ' < %<.in > %<.out')<CR>
imap <S-F10> <ESC><S-F10>

map <F8> <F9><F10>
imap <F8> <ESC><F8>
map <S-F8> <F9><S-F10>
imap <S-F8> <ESC><S-F8>

" ---------------------- Test Data -----------------------------
nmap <F12> <C-W>35v:e %<.in<CR>:set nocursorline nocursorcolumn<CR>:w<CR>:sp<CR><C-W>j:e %<.out<CR><C-w>l
imap <F12> <ESC><F12>a
nmap <S-F12> 100<C-W>l<C-W>h:wq<CR>:wq<CR>
imap <S-F12> <ESC><S-F12>a
" nmap <C-F12> <C-W>50v:e %<.err<CR>:set nocursorline nocursorcolumn<CR>:10sp %<.out<CR>:25vs %<.in<cr><c-w>2l
" imap <C-F12> <ESC><C-F12>a
" nmap <C-S-F12> 100<C-W>l<C-W>h:wq<CR>:wq<CR>:wq<CR>
" imap <C-S-F12> <ESC><C-S-F12>a

" ---------------------- MAP-Functions -------------------------
map <home> ^
imap <home> <c-o>^
nmap <tab> :
noremap 0 ^
inoremap <C-F> <C-n>
inoremap <C-E> <C-O>A
inoremap <C-L> <del>
noremap J L
noremap K H
noremap H ^
noremap L $
map ` :noh<CR>
vmap <Left> h
vmap <Right> l
vmap <Up> k
vmap <Down> j
inoremap <C-Up> <c-o><c-e>
inoremap <C-Down> <c-o><c-y>
nnoremap <C-Up> <c-e>
nnoremap <C-Down> <c-y>
map <C-j> 7j
map <C-k> 7k
map <C-h> 7h
map <C-l> 7l
nnoremap <Space> :
vmap <BS> c
inoremap <c-f> <c-n>
set backspace=indent,eol,start whichwrap+=<,>,[,]

" ---------------------- My Functions --------------------------
inoremap <leader>memset <ESC><Right>b"aywdwamemset(<C-R>a, 0, sizeof(<C-R>a));
nnoremap <leader>s <Right>b"bye/\<<C-r>b\><CR>
inoremap <leader>s <ESC><Right>b"bye/\<<C-r>b\><CR>
nnoremap <leader>m I(<ESC>A<left>) %= mod<ESC>j
inoremap <leader>mod <ESC>I(<ESC>A<left>) %= mod
vnoremap <leader>l ^<C-V>I//<ESC>
vnoremap <leader>. ^<c-v>I//<esc>
nnoremap <leader>. I//<ESC>j
nnoremap <leader>,  ^d2lj
vnoremap <leader>h <C-V>^2ld
inoremap <leader>freopen freopen("<C-r>%<C-w>in", "r", stdin);<CR>freopen("<c-r>%<c-w>out", "w", stdout);
inoremap <leader>format <C-O>:! clang-format -i %<CR>

" ---------------------- extensions ----------------------------

source ~/.vim/extensions/main.vim
if filereadable(expand('~/.vim/extensions/local.vim'))
    source ~/.vim/extensions/local.vim
endif

autocmd BufNewFile Makefile {
    exec 'read ~/.vim/templates/Makefile'
    normal kdd
    call cursor(1, 1)
}
let g:author = "hydropek <hydropek@outlook.com>"
autocmd BufNewFile *.cpp {
    call setline(1, "// author: " .. g:author)
    exec 'read ~/.vim/templates/default.cpp'
    call cursor(1, 1)
}
autocmd BufNewFile *.c {
    call setline(1, "// author: " .. g:author)
    exec 'read ~/.vim/templates/default.c'
    call cursor(1, 1)
}
autocmd BufNewFile *.py {
    call setline(1, '#!/usr/bin/env python3')
    call setline(2, "# author: " .. g:author)
}
autocmd BufNewFile *.sh {
    call setline(1, '#!/usr/bin/env zsh')
    call setline(2, "# author: " .. g:author)
}
