function! TestCharsOfEmpty()
  call lab42#test#assert_eq([], lab42#str#to_chars(''))
endfunction

function! TestCharsOfUnEmpty()
  call lab42#test#assert_eq(['a', ' ', ' ', 'b', 'c', ' '], lab42#str#to_chars('a  bc '))
endfunction

function! TestApostrohe()
  call lab42#test#assert_eq(['a', '''', 'b', 'c', ''''], lab42#str#to_chars("a'bc'"))
endfunction
