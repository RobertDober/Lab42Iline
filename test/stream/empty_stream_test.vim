
function! TestIsEmpty()
  let l:empty_stream = stream#empty()
  call lab42#test#assert_eq(1,l:empty_stream.is_empty())
  let l:not_empty = stream#cons(1, stream#make_empty())
  call lab42#test#assert_eq(0,l:not_empty.is_empty())
  call lab42#test#assert_eq(1,l:not_empty.tail().is_empty())
endfunction
