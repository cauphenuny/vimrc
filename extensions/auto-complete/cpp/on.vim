" auto filling contents
function! TypeSmall()
    if getline('.')[col('.') - 2] == '(' && getline('.')[col('.') - 1] == ')'
        return "\<Right>"
    else
        return ')'
    endif
endfunction

function! TypeSmallQuote()
    if getline('.')[col('.') - 2] == "'"  && getline('.')[col('.') - 1] == "'"
        return "\<Right>"
    else
        return "''\<Left>"
    endif
endfunction

function! TypeQuote()
    if getline('.')[col('.') - 2] == '"' && getline('.')[col('.') - 1] == '"'
        return "\<Right>"
    else
        return "\"\"\<Left>"
    endif
endfunction

function! TypeMid()
    if getline('.')[col('.') - 2] == '[' && getline('.')[col('.') - 1] == ']'
        return "\<Right>"
    elseif getline('.')[col('.') - 3] == '[' && getline('.')[col('.') - 1] == ']'
        return "\<Right>"
    else
        return ']'
    endif
endfunction

function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

function! Enter()
    if getline('.')[col('.') - 2] == '{' && getline('.')[col('.') - 1] == '}'
        return "\<CR>\<BS>\<Up>\<ESC>A\<CR>"
    else
        return "\<CR>"
    endif
endfunction

function! Tab()
    if getline('.')[col('.') - 1] == ']'
        return "\<Right>"
    elseif getline('.')[col('.') - 1] == ')'
        return "\<Right>"
    elseif getline('.')[col('.') - 1] == '"'
        return "\<Right>"
    else
        return "\<Tab>"
    endif
endfunction

function! Del()
    if getline('.')[col('.') - 1] == ']' && getline('.')[col('.') - 2] == '['
        return "\<right>\<BS>\<BS>"
    elseif getline('.')[col('.') - 1] == '}' && getline('.')[col('.') - 2] == '{'
        return "\<right>\<BS>\<BS>"
    elseif getline('.')[col('.') - 1] == ')' && getline('.')[col('.') - 2] == '('
        return "\<right>\<BS>\<BS>"
    elseif getline('.')[col('.') - 1] == '"' && getline('.')[col('.') - 2] == '"'
        return "\<right>\<BS>\<BS>"
    elseif getline('.')[col('.') - 1] == "'" && getline('.')[col('.') - 2] == "'"
        return "\<right>\<BS>\<BS>"
    else
        return "\<BS>"
    endif
endfunction

inoremap ( ()<ESC>i
inoremap ) <c-r>=TypeSmall()<CR>
inoremap { {}<ESC>i
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=TypeMid()<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap <CR> <c-r>=Enter()<CR>
inoremap <S-CR> <c-r>=Enter()<CR>
inoremap <BS> <c-r>=Del()<CR>
inoremap <C-BS> <BS>
inoremap " <c-r>=TypeQuote()<cr>
inoremap ' <c-r>=TypeSmallQuote()<cr>
inoremap <Tab> <c-r>=Tab()<cr>
":inoremap < <><ESC>i
