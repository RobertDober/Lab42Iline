function! TestSplit() " {{{{{
  let l:subject  = 'a'
  let l:expected = ['a']
  let l:result   = lab42#string#split(l:subject, 'b')
  call lab42#test#assert_eq(l:expected, l:result)
  
  let l:subject  = 'a b'
  let l:expected = ['a', ' ', 'b']
  let l:result   = lab42#string#split(l:subject, ' ')
  call lab42#test#assert_eq(l:expected, l:result)
  
  let l:subject  = 'a  bc d '
  let l:expected = ['a', '  ', 'bc', ' ', 'd', ' ']
  let l:result   = lab42#string#split(l:subject, '\s\+')
  call lab42#test#assert_eq(l:expected, l:result)

endfunction " }}}}}
