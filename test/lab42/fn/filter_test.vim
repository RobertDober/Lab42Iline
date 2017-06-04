
function! s:match(pattern, rgx)
  return match(a:pattern, '\v' . a:rgx) >= 0
endfunction

function! s:matches(rgx)
  return lab42#fn#partial_1(function('s:match'), a:rgx)
endfunction

function! TestSimpleFilter()
  let l:list     = ['the', 'quick', 'brown']

  let l:result   = lab42#fn#filter(l:list, s:matches('i'))
  let l:expected = ['quick']
  call lab42#test#assert_eq(l:expected, l:result)

endfunction
