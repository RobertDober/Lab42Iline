function! s:sum(acc, val_idx_pair)
  let [l:val, l:idx] = a:val_idx_pair
  return a:acc + l:val + l:idx
endfunction

function! s:scan(acc, val_idx_pair)
  return extend(a:acc, a:val_idx_pair)
endfunction
function! TestFoldlWithIndex()
  let l:values = range(10)
  let l:sum_with_index = lab42#fn#foldl_with_index(l:values, 0, function('s:sum'))
  call lab42#test#assert_eq(90, l:sum_with_index)


  let l:scan_with_index = lab42#fn#foldl_with_index(range(2,4), [], function('s:scan'))
  call lab42#test#assert_eq([2, 0, 3, 1, 4, 2], l:scan_with_index)

endfunction
