function! s:addDoubleIndex(val, idx)
  return a:val + 2 * a:idx
endfunction
let s:Double = function('s:addDoubleIndex')


function! TestMapWithIndex()
  let l:list     = range(4)

  let l:result   = lab42#fn#map_with_index(l:list, s:Double)
  let l:expected = [0, 3, 6, 9]
  call lab42#test#assert_eq(l:expected, l:result)


  let l:result   = lab42#fn#map_with_index(l:list, s:Double, 1, 3)
  let l:expected = [2, 9, 16, 23]
  " indices are    [1, 4,  7, 10]
  call lab42#test#assert_eq(l:expected, l:result)
endfunction
