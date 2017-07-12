
function! TestSomeFiniteStreams()
  let l:one = stream#cons(1, stream#make_empty())
  call lab42#test#assert_eq(0, l:one.is_empty())
  call lab42#test#assert_eq(1, l:one.head())
  let l:tail = l:one.tail()
  call lab42#test#assert_eq(1, l:tail.is_empty())
endfunction

function! s:integers(from)
  return stream#cons(a:from, funcref('s:integers', [a:from + 1]))
endfunction
function! TestInfiniteStream()
  let l:integers = s:integers(0)
  call lab42#test#assert_eq(0, l:integers.head())
  call lab42#test#assert_eq(0, l:integers.tail().is_empty())
  call lab42#test#assert_eq(2, l:integers.tail().tail().head())
endfunction
