source ~/.vim/common_vimrc 

set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd FileType yaml {
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
}

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

set rtp+=/opt/homebrew/opt/fzf

" ---------------------- Map Functions ----------------------


" Get filename
abbr ,f <C-R>=expand("%:")<left><left>
" Get current working dir
abbr ,c <C-R>=getcwd()<cr>

" Generate UUID
abbr ,g <C-R>=substitute(system('uuidgen'), '\n\+$', '', '')<cr>
" Get time
abbr ,d <C-R>=substitute(system('LC_TIME=en_US.UTF-8 date'), '\n\+$', '', '')<cr>

" Switch modifiable attribute
nnoremap <silent> ,m :setl ma! ma?<cr>

" Convert MACROS from iden-tifiers to IDEN_TIFIERS
nnoremap ,u mpgUiW"pciW<C-R>=substitute(@p,'-','_','ge')<CR><ESC>`p:delm p<cr>
inoremap ,u <ESC>mpgUiW"pciW<C-R>=substitute(@p,'-','_','ge')<CR><ESC>`p:delm p<CR>a

" ---------------------- Easy Motion Settings ----------------------

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" Gif config
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" Gif config

map <space> <leader>

nmap s <Plug>(easymotion-s)

map <leader>noh :noh
map <leader>w :w
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

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
autocmd Filetype c,cpp {
    b:cc = {}
    b:cc.opts = ['-Wall', '-Wextra', '-Wshadow', '-DLOCAL']
    b:cc.pkgs = []
}

autocmd Filetype cpp {
    b:cc.compiler = 'clang++'
    b:cc.std = 'c++23'
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
    let name = split(system('pwd | md5sum'))[0]
    let file = g:ccenv_dir . name
    call system('touch '.file)
    let info = b:cc.compiler . ' ' . b:cc.std . '\n' . join(b:cc.opts).'\n'.join(b:cc.pkgs)
    call system('echo "'.info.'" > '.file)
endfunc

func! ReadOption()
    let name = split(system('pwd | md5sum'))[0]
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
        exec '!echo "'.a:cmd.'" && '.a:cmd
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

func! GetCompileCommand()
    if &modified
        exec 'w'
    endif
    if &filetype == 'cpp' || &filetype == 'c' || &filetype == 'make'
        if filereadable(expand("./Makefile"))
            return 'make'
        else
            return b:cc.compiler.' % -o %< -std='.b:cc.std.' '.GetCompileOption()
        endif
    elseif &filetype == 'haskell'
        return 'ghc %'
    elseif &filetype == 'rust'
        return 'rustc %'
    elseif &filetype == 'java'
        return 'javac %'
    elseif &filetype == 'html'
        return 'open %'
    elseif &filetype == 'go'
        return 'go build %'
    else
        return ''
    endif
endfunc

func! GetRunCommand()
    if &filetype == 'cpp' || &filetype == 'c' || &filetype == 'make'
        if filereadable(expand("./Makefile"))
            return 'make run'
        else
            return 'time ./%<'
        endif
    elseif &filetype == 'rust'
        return 'time ./%<'
    elseif &filetype == 'haskell'
        return 'time ./%<'
    elseif &filetype == 'python'
        return 'time python3 %'
    elseif &filetype == 'python'
        return 'time java ./%'
    elseif &filetype == 'go'
        return 'time ./%<'
    elseif &filetype == 'sh'
        return 'zsh %'
    endif
endfunc

map <F9> :call EchoRun(GetCompileCommand())<CR>
imap <F9> <ESC><F9>

map <F10> :call EchoRun(GetRunCommand())<CR>
imap <F10> <ESC><F10>

map <S-F10> :call EchoRun(GetRunCommand() . ' < %<.in > %<.out')<CR>
imap <S-F10> <ESC><S-F10>

map <F8> :call EchoRun(GetCompileCommand() . " && echo '--- runing ---'" . " && " . GetRunCommand())<CR>
imap <F8> <ESC><F8>
map <S-F8> :call EchoRun(GetCompileCommand() . " && echo '--- runing ---'" . ' && ' . GetRunCommand() . ' < %<.in > %<.out')<CR>
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


" ---------------------- My Functions --------------------------
inoremap <leader>memset <ESC><Right>b"aywdwamemset(<C-R>a, 0, sizeof(<C-R>a));
nnoremap <leader>m I(<ESC>A<left>) %= mod<ESC>j
inoremap <leader>mod <ESC>I(<ESC>A<left>) %= mod
vnoremap <leader>l ^<C-V>I//<ESC>
vnoremap <leader>. ^<c-v>I//<esc>
vnoremap <leader>, <C-V>^2ld
inoremap <leader>freopen freopen("<C-r>%<C-w>in", "r", stdin);<CR>freopen("<c-r>%<c-w>out", "w", stdout);
" inoremap <leader>format <C-O>:! clang-format -i %<CR>

" if has('mac')
"     function SwitchInput()
"         let w:stored_input = split(system('input_selector current'))[0]
"         if w:stored_input != "com.apple.keylayout.ABC"
"             exec system('input_selector select com.apple.keylayout.ABC')
"         endif
"     endfunction
"     set ttimeoutlen=100
"     call SwitchInput()
"     autocmd InsertLeave * call SwitchInput()
"     autocmd InsertEnter * {
"         if !exists("w:stored_input") 
"             w:stored_input = split(system('input_selector current'))[0]
"         endif
"         if split(system('input_selector current'))[0] != w:stored_input
"             exec system("input_selector select " .. w:stored_input)
"         endif
"     }
" endif

" ---------------------- extensions ----------------------------

source ~/.vim/extensions/main.vim

autocmd BufNewFile Makefile {
    exec 'read ~/.vim/templates/Makefile'
    normal kdd
    call cursor(1, 1)
}
autocmd BufNewFile cmake {
    exec 'read ~/.vim/templates/CMakeLists.txt'
    normal kdd
    call cursor(1, 1)
}
let g:author = "Cauphenuny <https://cauphenuny.github.io/>"
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
autocmd BufNewFile *.typ {
    exec 'read ~/.vim/templates/preamble.typ'
    normal kdd
}
autocmd BufNewFile *.py {
    call setline(1, '#!/usr/bin/env python3')
    call setline(2, "# author: " .. g:author)
}
autocmd BufNewFile *.sh {
    call setline(1, '#!/usr/bin/env zsh')
    call setline(2, "# author: " .. g:author)
}

set dictionary+=/usr/share/dict/words
inoremap <C-F> <C-X><C-K>
