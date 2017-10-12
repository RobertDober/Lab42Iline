function! TestGetEleFn()
  let l:input = [[0, 1], [1, 2], [2, 3]] 

  let l:result0 = lab42#fn#map(l:input, lab42#fn#get_ele_fn(0))
  call lab42#test#assert_eq(range(3), l:result0)

  let l:result1 = lab42#fn#map(l:input, lab42#fn#get_ele_fn(1))
  call lab42#test#assert_eq(range(1, 3), l:result1)
endfunction
