
let s:count = 0

function! s:inc()
  let s:count += 1
  return s:count 
endfunction

function! TestMemFun()
  call lab42#test#assert_eq(1, s:inc())
  call lab42#test#assert_eq(2, s:inc())
  let l:Inc = lab42#fn#memfun(function('s:inc'))
  call lab42#test#assert_eq(3, call(l:Inc, []))
  call lab42#test#assert_eq(3, call(l:Inc, []))
  " memoize again is not the same function
  let l:Inc1 = lab42#fn#memfun(function('s:inc'))
  call lab42#test#assert_eq(4, call(l:Inc1, []))
  call lab42#test#assert_eq(4, call(l:Inc1, []))
endfunction

