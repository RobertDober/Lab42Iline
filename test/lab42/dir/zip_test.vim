function! TestSimpleZip() " {{{{{
  let l:data = {'a': [1, 2], 'b': ['a', 'b'], 'c': [1, 0]}
  let l:result = lab42#dir#zip(l:data)

  let l:expected =  []
  let l:expected += [{'a': 1, 'b': 'a', 'c': 1}]
  let l:expected += [{'a': 2, 'b': 'b', 'c': 0}]
  call lab42#test#assert_eq(l:expected, l:result)
endfunction " }}}}}

function! TestCutToShortest() " {{{{{
  let l:data = {'a': [1, 2, 3], 'b': ['a', 'b'], 'c': [1, 0, 3]}
  let l:result = lab42#dir#zip(l:data)

  let l:expected =  []
  let l:expected += [{'a': 1, 'b': 'a', 'c': 1}]
  let l:expected += [{'a': 2, 'b': 'b', 'c': 0}]
  
endfunction " }}}}}
