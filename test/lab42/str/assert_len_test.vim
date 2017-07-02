function! TestAssertLen()
  call lab42#test#assert_eq('hello ', lab42#str#assert_length(6, 'hello'))
  call lab42#test#assert_eq('hello', lab42#str#assert_length(5, 'hello'))
  call lab42#test#assert_eq('hello', lab42#str#assert_length(4, 'hello'))
  call lab42#test#assert_eq('hello ', lab42#str#assert_length(4, 'hello '))
endfunction
