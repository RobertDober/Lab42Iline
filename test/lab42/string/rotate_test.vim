function! TestDefaultAroundSpaces() " {{{{{
  let l:subject = "a b"

  let l:expected = "b a"
  let l:result = lab42#string#rotate(l:subject)
  call lab42#test#assert_eq(l:expected, l:result)
endfunction " }}}}}
