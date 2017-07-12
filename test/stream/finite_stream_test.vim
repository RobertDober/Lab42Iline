function! TestFromArray()
  let l:digits = stream#finite(range(10))

  call lab42#test#assert_eq(range(10), l:digits.take(10) )
  call lab42#test#assert_eq(range(10), l:digits.all() )

  let l:forever = l:digits.cycle()
  call lab42#test#assert_eq(extend(range(5, 9), range(5)), l:forever.drop(5).take(10) )

  call lab42#test#assert_true(stream#empty().cycle().is_empty())

endfunction
