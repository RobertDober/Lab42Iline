let s:digits = range(10)

function! s:odd(n)
  return lab42#data#option(a:n % 2, a:n) 
endfunction

function! s:bareOdd(n)
  return a:n % 2
endfunction

function! TestBasicFind()
  let l:found = lab42#fn#find(s:digits, function('s:odd'))
  call lab42#test#assert_eq(1, l:found.some())
  call lab42#test#assert_eq(1, l:found.val())

  let l:found = lab42#fn#find([0, 2, 5], function('s:odd'))
  call lab42#test#assert_eq(5, l:found.val())

  let l:found = lab42#fn#find([0, 2, 6], function('s:odd'))
  call lab42#test#assert_eq(0, l:found.some())

  let l:found = lab42#fn#find([0, 2, 6], function('s:odd'), 42)
  call lab42#test#assert_eq(1, l:found.some())
  call lab42#test#assert_eq(42, l:found.val())
endfunction

function! TestWrappedFind() " {{{{{
  let l:found = lab42#fn#bare_find(s:digits, function('s:bareOdd'))
  call lab42#test#assert_eq(1, l:found.some())
  call lab42#test#assert_eq(1, l:found.val())

  let l:found = lab42#fn#bare_find([0, 2, 5], function('s:bareOdd'))
  call lab42#test#assert_eq(5, l:found.val())

  let l:found = lab42#fn#bare_find([0, 2, 6], function('s:bareOdd'))
  call lab42#test#assert_eq(0, l:found.some())

  let l:found = lab42#fn#bare_find([0, 2, 6], function('s:bareOdd'), 42)
  call lab42#test#assert_eq(1, l:found.some())
  call lab42#test#assert_eq(42, l:found.val())
endfunction " }}}}}
