function! s:double(n)
  return a:n . a:n
endfunction

function! TestFromList()
  let l:list = [['a', 1], ['b', 2]]
  call lab42#test#assert_eq({'a': 1, 'b': 2}, lab42#fn#dict_from_list(l:list))
  " Non destructive
  call lab42#test#assert_eq([['a', 1], ['b', 2]], l:list)
endfunction

function! TestGetWithDefault()
  let l:dict = {'a': 1, 'b': 2}
  call lab42#test#assert_eq(1, lab42#fn#get_with_default(l:dict, 'a', 42))
  call lab42#test#assert_eq(2, lab42#fn#get_with_default(l:dict, 'b', 42))
  call lab42#test#assert_eq(42, lab42#fn#get_with_default(l:dict, 'c', 42))
  call lab42#test#assert_eq('cc', lab42#fn#get_with_default(l:dict, 'c', function('s:double')))
endfunction
