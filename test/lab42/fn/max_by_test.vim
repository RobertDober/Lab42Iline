function! s:extractNumber(str) " {{{{{
  let l:stripped = substitute(a:str, '\v\D+', '', '')
  return str2nr(l:stripped)
endfunction " }}}}}

function! TestMaxBy() " {{{{{
  let l:list = ['alpha42', 'alpha9', 'alpha100']

  let l:result = lab42#fn#max_by(l:list, function('s:extractNumber'))
  call lab42#test#assert_eq('alpha100', l:result)
endfunction " }}}}}

function! TestMaxByAndApply() " {{{{{
  let l:list = ['alpha42', 'alpha9', 'alpha100']

  let l:result = lab42#fn#max_by_and_apply(l:list, function('s:extractNumber'))
  call lab42#test#assert_eq(100, l:result)
endfunction " }}}}}
