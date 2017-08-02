
function! TestParseUpTo()
  call lab42#test#assert_eq([1, "hello"], lab42#parse#up_to('hello)', ')'))
endfunction
