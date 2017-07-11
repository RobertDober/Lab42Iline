function! TestZipTwo()
  let l:lhs = range(3)
  let l:rhs = ['a', 'b', 'c']
  let l:expected = [[0, 'a'], [1, 'b'], [2, 'c']]
  let l:actual   = lab42#fn#zip(l:lhs, l:rhs)
  call lab42#test#assert_eq(l:expected, l:actual)
endfunction
