function! s:sum(acc, pair)
  let [l:lhs, l:rhs] = a:pair
  return add(a:acc, l:lhs + l:rhs)
endfunction

function! TestFoldln()
  let l:values = range(10)
  let l:sums   = lab42#fn#foldln(l:values, 2, [], function('s:sum'))

  call lab42#test#assert_eq([1, 5, 9, 13, 17], l:sums )
endfunction
