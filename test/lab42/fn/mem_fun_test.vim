
let s:count = 0
let s:string = ''

function! s:inc()
  let s:count += 1
  return s:count 
endfunction

function! s:append()
  let s:string .= '.'
  return s:string
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
  " first not impacted
  call lab42#test#assert_eq(3, call(l:Inc, []))
  let l:App = lab42#fn#memfun(function('s:append'))
  call lab42#test#assert_eq('.', l:App())
endfunction

function! s:closure() dict
  let self.x += 1
  return self.x
endfunction
function! s:make_closure()
  return function('s:closure', [], {'x': 0})
endfunction
function! TestClosure()
  let l:C1 = s:make_closure()
  let l:C2 = s:make_closure()
  call lab42#test#assert_eq(1, l:C1())
  call lab42#test#assert_eq(1, l:C2())
  call lab42#test#assert_eq(2, l:C2())
  call lab42#test#assert_eq(2, l:C1())
endfunction
