function! TestInc()
  call lab42#test#assert_eq(2, call(lab42#fn#inc(), [1]))
endfunction

function! TestZipWithFn()
  let l:list = range(4)
  call lab42#test#assert_eq([[0, 1], [1, 2], [2, 3], [3, 4]], lab42#fn#zip_with(l:list, lab42#fn#inc()))
endfunction
