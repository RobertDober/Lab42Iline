

function! TestExample()
  let l:input = [ 
    \ [['a', 'b', 'c'], 3], 
    \ [[], 42], 
    \ [['alpha'], 0] ]

  let l:NotEmpty = lab42#fn#compose(lab42#fn#get_ele_fn(0), lab42#fn#negate(lab42#fn#empty_fn()))
  let l:not_empty = lab42#fn#filter(l:input, l:NotEmpty)
  let l:expected = [ 
    \ [['a', 'b', 'c'], 3], 
    \ [['alpha'], 0] ]
  call lab42#test#assert_eq(l:expected, l:not_empty)

  let l:LongerThan2  = lab42#fn#compose(lab42#fn#get_ele_fn(0), lab42#fn#negate(lab42#fn#list_shorter_than_fn(3)))
  let l:longer_than2 = lab42#fn#filter(l:input, l:LongerThan2)
  let l:expected = [ 
    \ [['a', 'b', 'c'], 3]] 
  call lab42#test#assert_eq(l:expected, l:longer_than2)

endfunction

function! TestSimple()
  let l:input = ['a', '', 'b']
  let l:NotEmpty = lab42#fn#negate(lab42#fn#empty_fn())

  let l:result = lab42#fn#filter(l:input, l:NotEmpty)
  call lab42#test#assert_eq(['a', 'b'], l:result )

endfunction
