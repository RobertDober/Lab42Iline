
function! s:sum(l,r)
  return a:l + a:r
endfunction


function! TestMapSlice()
  let l:list = range(8)
  let l:result = lab42#fn#mapn(l:list, 2, function('s:sum'))
  call lab42#test#assert_eq([1, 5, 9, 13], l:result)

endfunction
