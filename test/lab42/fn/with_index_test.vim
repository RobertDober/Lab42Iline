
function! TestWithIndex()
  call lab42#test#assert_eq([], lab42#fn#with_index([]))
  call lab42#test#assert_eq([['a', 0], ['b', 1], ['c', 2]], lab42#fn#with_index(['a', 'b', 'c']))
  call lab42#test#assert_eq([['a', 2], ['b', 3], ['c', 4]], lab42#fn#with_index(['a', 'b', 'c'], 2))
  call lab42#test#assert_eq([['a', 3], ['b', 1], ['c', -1]], lab42#fn#with_index(['a', 'b', 'c'], 3, -2))
endfunction
