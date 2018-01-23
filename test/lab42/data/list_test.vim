
function! TestSimpleWordAccess() " {{{{{
  let l:elements = ['a', 'b']
  let l:list    = lab42#list#new(l:elements)

  call lab42#test#assert_eq('a', l:list.first())
  call lab42#test#assert_eq('b', l:list.second())
  call lab42#test#assert_eq('b', l:list.second('x'))
  call lab42#test#assert_eq('b', l:list.last())

  
  let l:elements = ['a']
  let l:list    = lab42#list#new(l:elements)

  call lab42#test#assert_eq('a', l:list.first())
  call lab42#test#assert_eq(0, l:list.second())
  call lab42#test#assert_eq('x', l:list.second('x'))
  call lab42#test#assert_eq('a', l:list.last('y'))

  call lab42#test#assert_eq('a', l:list.get(0))
  call lab42#test#assert_eq('a', l:list.get(-1, 'y'))
  call lab42#test#assert_eq('z', l:list.get(1, 'z'))
  call lab42#test#assert_eq('u', l:list.get(-2, 'u'))

endfunction " }}}}}

