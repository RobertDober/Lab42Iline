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

function! TestTriples() " {{{{{
  let l:data = { 'a': [1, 2], 'b': ['x', 'y'], 'c': range(3) }

  let l:result = lab42#dir#carthesian(l:data, ['a', 'b', 'c'])
  let l:expected =  []
  let l:expected += [{'a': 1, 'b': 'x', 'c': 0}]
  let l:expected += [{'a': 1, 'b': 'x', 'c': 1}]
  let l:expected += [{'a': 1, 'b': 'x', 'c': 2}]
  let l:expected += [{'a': 1, 'b': 'y', 'c': 0}]
  let l:expected += [{'a': 1, 'b': 'y', 'c': 1}]
  let l:expected += [{'a': 1, 'b': 'y', 'c': 2}]
  let l:expected += [{'a': 2, 'b': 'x', 'c': 0}]
  let l:expected += [{'a': 2, 'b': 'x', 'c': 1}]
  let l:expected += [{'a': 2, 'b': 'x', 'c': 2}]
  let l:expected += [{'a': 2, 'b': 'y', 'c': 0}]
  let l:expected += [{'a': 2, 'b': 'y', 'c': 1}]
  let l:expected += [{'a': 2, 'b': 'y', 'c': 2}]
  call lab42#test#assert_eq(l:expected, l:result)
  
endfunction " }}}}}
