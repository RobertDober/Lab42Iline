
function! s:tokens(line, expected) " {{{{{
  let l:result = lab42#string#tokens(a:line, '[]()""' . "''{}")
  call lab42#test#assert_eq(a:expected, l:result)
endfunction " }}}}}

function! TestEmpty() " {{{{{
  call s:tokens("", [])
  call s:tokens("abc", [])
  call s:tokens("a bc ", [])
endfunction " }}}}}

function! TestNotEmpty() " {{{{{
  call s:tokens("(", ["("])
  call s:tokens("{ [a '", ["{", "[", "'"])
endfunction " }}}}}
