" https://github.com/q60/vim-brainfuck/blob/master/syntax/brainfuck.vim
syn keyword bfTodo
	\ TODO
	\ FIXME
	\ NOTE
	\ ToDo
	\ FixMe
	\ Note

" Match brackets
syn match bfBrackets /[\[\]]/

" Match plus and minus signs
syn match bfByte /[\+-]/

" Match IO operators
syn match bfIO /[\.,]/

" Match data pointer increment/decrement operators
syn match bfCell /[><]/

" Match comments
syn match bfComment /!.*/ contains=bf_todo
" syn region bf_comment_multiline start=/\/\*/ end=/\*\// contains=bf_todo

" Higlight
hi def link bfTodo Conditional
hi def link bfBrackets Conditional
hi def link bfByte Operator
hi def link bfIO String
hi def link bfCell Delimiter
hi def link bfComment Comment
" hi def link bf_comment_multiline Comment

let b:current_syntax='brainfuck'

