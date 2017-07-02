function! TestSuffixPresent()
  call lab42#test#assert_eq('hello', lab42#str#assure_suffix('hello', 'o'))
endfunction

function! TestSuffixPresentSpacesRemoved()
  call lab42#test#assert_eq('hello', lab42#str#assure_suffix('hello ', 'o'))
endfunction

function! TestSuffixNotPresent()
  call lab42#test#assert_eq('hello', lab42#str#assure_suffix('hell', 'o'))
endfunction

function! TestSuffixNotPresentSpacesRemoved()
  call lab42#test#assert_eq('hello', lab42#str#assure_suffix('hell ', 'o'))
endfunction

function! TestSuffixSpecialChars()
  call lab42#test#assert_eq('hell {', lab42#str#assure_suffix('hell ', ' {'))
endfunction

function! TestSuffixWithSpaces()
  call lab42#test#assert_eq('hello <', lab42#str#assure_suffix('hello', ' <'))
endfunction

function! TestSuffixWithSpacesAlreadyPresent()
  call lab42#test#assert_eq('hello <', lab42#str#assure_suffix('hello ', ' <'))
endfunction
