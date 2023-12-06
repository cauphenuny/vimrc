" ---------------------- Global settings ----------------------
set number
set ruler
set showcmd
set mouse=a
set cursorline
"set cursorcolumn
set nocompatible

set expandtab
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
function! Compile()
"   return g++ %<.cpp -g -DLOCAL_MAC -o %< -Wall -std=c++03"
     return "g++ %<.cpp -g -DLOCAL_MAC -o %< -Wall -std=c++17"
"    return g++ %<.cpp -g -DLOCAL_MAC -O2 -o %< -Wall"
endfunction


map <C-F10> :!./%<<CR>
"map <F10> <C-F10>
map <S-F10> :!./%< < %<.in > %<.out 2> %<.err<cr>
map <F10> :!./%< < %<.in > %<.out<CR>
map <C-F9> :!<C-R>=Compile()<CR> && ./%<<CR>
map <F9> :!<C-R>=Compile()<CR> && ./%< < %<.in > %<.out 2> %<.err<CR>
map <S-F9> :!<C-R>=Compile()<CR> && ./%< < %<.in > %<.out<CR>
imap <F9> <ESC><F9>
imap <S-F9> <ESC><S-F9>
imap <C-F9> <ESC><C-F9>
map <F11> :!<C-R>=Compile()<CR><CR>
imap <F11> <ESC><F11>

" ---------------------- Test Data ----------------------
nmap <F12> <C-W>35v:e %<.in<CR>:set nocursorline nocursorcolumn<CR>:sp<CR><C-W>j:e %<.out<CR><C-w>l
imap <F12> <ESC><F12>a
nmap <S-F12> 100<C-W>l<C-W>h:wq<CR>:wq<CR>
imap <S-F12> <ESC><S-F12>a
nmap <C-F12> <C-W>50v:e %<.err<CR>:set nocursorline nocursorcolumn<CR>:10sp %<.out<CR>:25vs %<.in<cr><c-w>2l
imap <C-F12> <ESC><C-F12>a
nmap <C-S-F12> 100<C-W>l<C-W>h:wq<CR>:wq<CR>:wq<CR>
imap <C-S-F12> <ESC><C-S-F12>a

" ---------------------- MAP-Functions ----------------------
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
inoremap <F8> <Space><C-O>s<C-O>:update<CR>
nnoremap <F8> :update<CR>
inoremap <S-F8> <C-O>:wa<CR>
nnoremap <S-F8> :wa<CR>
inoremap <c-f> <c-n>
set backspace=indent,eol,start whichwrap+=<,>,[,]

" ---------------------- My Functions ----------------------
inoremap <leader>memset <ESC><Right>b"aywdwamemset(<C-R>a, 0, sizeof(<C-R>a));
inoremap <leader>for for (int i = 1; i <= n; i++) {<CR>}<up><end><cr>
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

" " ---------------------- extensions ----------------------
" 

source ~/.vim/extensions/main.vim

autocmd BufNewFile *.cpp exec 'read ~/.vim/templates/default.cpp'
autocmd BufNewFile *.cpp normal kddGkk
autocmd BufNewFile *.c exec 'read ~/.vim/templates/default.c'
autocmd BufNewFile *.c normal kddGkk
