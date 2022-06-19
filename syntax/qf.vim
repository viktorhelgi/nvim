if exists('b:current_syntax')
    finish
endif


syn match qfFileName /^[^│]*/ nextgroup=qfSeparatorLeft
syn match qfSeparatorLeft /│/ contained nextgroup=qfLineNr
syn match qfLineNr /[^│]*/ contained nextgroup=qfSeparatorRight
syn match qfSeparatorRight '│' contained nextgroup=qfKeyWords,qfBrackets,qfError,qfWarning,qfInfo,qfNote
syn match qfError / E .*$/ contained
syn match qfWarning / W .*$/ contained
syn match qfInfo / I .*$/ contained
syn match qfNote / [NH] .*$/ contained
syn match qfKeyWords / impl \| impl<\| struct \| trait \| for \| where \| fn \| enum /
syn match qfBrackets /{\|}\|<\|>\|:/
" syn region qfMainText /\d*\s*|\zs.*\ze/

hi def link qfFileName Directory
hi def link qfSeparatorLeft Delimiter
hi def link qfSeparatorRight Delimiter
hi def link qfLineNr LineNr
hi def link qfError CocErrorSign
hi def link qfWarning CocWarningSign
hi def link qfInfo CocInfoSign
hi def link qfNote CocHintSign

" hi normal guifg=#dbbc7F

" hi def link qfMainText Type 
" hi def link qfBrackets TSPuntBracket
hi def link qfKeyWords Keyword
hi qfBrackets guifg=#bb846b

hi QuickFixLine guifg=None guibg=#434b4e gui=undercurl

" hi def link qfBrackets CocHintSign
let b:current_syntax = 'qf'
