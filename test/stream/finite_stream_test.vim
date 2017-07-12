function! TestFromArray()
  let l:digits = stream#finite(range(10))

  call lab42#test#assert_eq(range(10), l:digits.take(10) )
  call lab42#test#assert_eq(range(10), l:digits.all() )


endfunction
