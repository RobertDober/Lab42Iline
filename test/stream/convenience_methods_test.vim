function! s:integers(from)
  return stream#cons(a:from, funcref('s:integers', [a:from + 1]))
endfunction

function! TestDrop()
  let l:integers = s:integers(1)
  call lab42#test#assert_eq(0, l:integers.tail().is_empty())
  call lab42#test#assert_eq(0, l:integers.tail().tail().is_empty())
  call lab42#test#assert_eq(2, l:integers.drop(1).head())
  call lab42#test#assert_eq(42, l:integers.drop(41).head())
endfunction

function! TestDropWhileUntil()
  let l:integers = s:integers(0)
  call lab42#test#assert_eq(3, l:integers.drop_while(lab42#fn#less_fn(3)).head())
  call lab42#test#assert_eq(4, l:integers.drop_until(lab42#fn#greater_fn(3)).head())
endfunction

function! TestTakeWhileUntil()
  let l:integers = s:integers(0)
  call lab42#test#assert_eq(range(3), l:integers.take_while(lab42#fn#less_fn(3)))
  call lab42#test#assert_eq(range(3), l:integers.take_until(lab42#fn#greater_fn(2)))
endfunction

function! TestTake()
  let l:integers = s:integers(1)
  call lab42#test#assert_eq([1, 2], l:integers.take(2))
  call lab42#test#assert_eq([3, 4, 5], l:integers.drop(2).take(3))
endfunction
