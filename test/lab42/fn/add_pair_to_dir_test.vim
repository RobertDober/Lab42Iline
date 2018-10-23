function! TestAddPairToDir() " {{{{{
  let l:dir = {'a': 42}
  call lab42#test#assert_eq({'a': 42, 'b': 11}, call(lab42#fn#add_pair_to_dir_fn(), [l:dir, ['b', 11]]))
endfunction " }}}}}
