
function! TestParseUpTo()
  call lab42#test#assert_eq([1, "hello)"], lab42#parse#up_to('hello)', '', ')'))
  call lab42#test#assert_eq([0, "hello)"], lab42#parse#up_to('hello)', '', ''))
  call lab42#test#assert_eq([0, "hello()42"], lab42#parse#up_to('hello()42', '(', ')'))
endfunction

function! TestParseUpToIncAndDec()
  call lab42#test#assert_eq([1, "hello(42))"], lab42#parse#up_to('hello(42))43', '(', ')'))
endfunction
