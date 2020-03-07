function! TestSetFromList() " {{{{{
  let l:result = lab42#fn#set_from_list([])
  let l:expected = {}
  call lab42#test#assert_eq(l:expected, l:result)

  let l:result = lab42#fn#set_from_list(['a', 'b'])
  let l:expected = {'a': 1, 'b': 1}
  call lab42#test#assert_eq(l:expected, l:result)
endfunction " }}}}}
