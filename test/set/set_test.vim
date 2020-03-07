function! TestSetFromList() " {{{{{
  let l:result = lab42#set#set_from_list([])
  let l:expected = {}
  call lab42#test#assert_eq(l:expected, l:result)

  let l:result = lab42#set#set_from_list(['a', 'b'])
  let l:expected = {'a': 1, 'b': 1}
  call lab42#test#assert_eq(l:expected, l:result)
endfunction " }}}}}

function! TestIndexedSetFromList() " {{{{{
  let l:result = lab42#set#indexed_set_from_list(['a', 'b', 'c'])
  let l:expected = {'a': 1, 'b': 2, 'c': 3}
  call lab42#test#assert_eq(l:expected, l:result)
endfunction " }}}}}

function! TestFilterBySetMembership() " {{{{{
  let l:vowels = lab42#set#set_from_list(['a', 'e', 'i', 'o', 'u'])
  let l:result = lab42#fn#filter(['a', 'b', 'c', 'e', 'f'], lab42#set#is_member_fn(l:vowels))
  let l:expected = ['a', 'e']
  call lab42#test#assert_eq(l:expected, l:result)
endfunction " }}}}}
