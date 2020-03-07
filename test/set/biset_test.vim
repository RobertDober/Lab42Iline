function! TestBiSetCreation() " {{{{{
  let l:biset = lab42#set#biset_from_lists(split("abc", '\s*'), split("ABC", '\s*'))
  let l:expected = [{'a': 'A', 'b': 'B', 'c': 'C'}, {'A': 'a', 'B': 'b', 'C': 'c'}]
  call lab42#test#assert_eq(l:expected, l:biset)
  call lab42#test#assert_eq('C', lab42#set#get_left(l:biset, 'c'))
  call lab42#test#assert_eq('b', lab42#set#get_right(l:biset, 'B'))
endfunction " }}}}}
