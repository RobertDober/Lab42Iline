
function! TestConstStream()
  let l:ones = stream#const_stream(1)

  call lab42#test#assert_false(l:ones.is_empty())
  for l:x in range(1, 3)
    for l:y in range(1, 3)
      call lab42#test#assert_eq(repeat([1], l:y), l:ones.drop(l:x).take(l:y))
    endfor
  endfor
endfunction
