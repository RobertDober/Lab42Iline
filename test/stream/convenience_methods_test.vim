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

function! TestTake()
  let l:integers = s:integers(1)
  call lab42#test#assert_eq([1, 2], l:integers.take(2))
  call lab42#test#assert_eq([3, 4, 5], l:integers.drop(2).take(3))

  
endfunction
