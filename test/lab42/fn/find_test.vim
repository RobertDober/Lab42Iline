let s:digits = range(10)

function! s:odd(n)
  return lab42#data#option(a:n % 2, a:n) 
endfunction

function! TestBasicFind()
  
  let l:found = lab42#fn#find(s:digits, function('s:odd'))
  call lab42#test#assert_eq(1, l:found.some())
  call lab42#test#assert_eq(1, l:found.val())

  let l:found = lab42#fn#find([0, 2, 5], function('s:odd'))
  call lab42#test#assert_eq(5, l:found.val())

  let l:found = lab42#fn#find([0, 2, 6], function('s:odd'))
  call lab42#test#assert_eq(0, l:found.some())
endfunction
