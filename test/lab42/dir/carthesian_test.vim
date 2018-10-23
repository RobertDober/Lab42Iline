function! TestSimpleProd() " {{{{{
  let l:data = { 'a': [1, 2], 'b': ['x', 'y'] }

  let l:result = lab42#dir#carthesian(l:data, ['a', 'b'])
  let l:expected =  [{'a': 1, 'b': 'x'}]
  let l:expected += [{'a': 1, 'b': 'y'}]
  let l:expected += [{'a': 2, 'b': 'x'}]
  let l:expected += [{'a': 2, 'b': 'y'}]
  call lab42#test#assert_eq(l:expected, l:result)

  
  let l:result = lab42#dir#carthesian(l:data, ['b', 'a'])
  let l:expected =  [{'a': 1, 'b': 'x'}]
  let l:expected += [{'a': 2, 'b': 'x'}]
  let l:expected += [{'a': 1, 'b': 'y'}]
  let l:expected += [{'a': 2, 'b': 'y'}]
  call lab42#test#assert_eq(l:expected, l:result)
endfunction " }}}}}
