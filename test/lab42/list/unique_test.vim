function! TestIdemPotentCases() " {{{{{
  
  call lab42#test#assert_eq([], lab42#list#unique([]))
  call lab42#test#assert_eq([1], lab42#list#unique([1]))
  call lab42#test#assert_eq([1, 2], lab42#list#unique([1, 2]))

endfunction " }}}}}

function! TestUniqCompatibility() " {{{{{
  call lab42#test#assert_eq([1, 2, 3], lab42#list#unique([1, 2, 2, 3, 3]))
endfunction " }}}}}

function! TestGeneralCase() " {{{{{
  call lab42#test#assert_eq([1, 2, 3, 4], lab42#list#unique([1, 2, 2, 1, 3, 4, 3, 2, 1]))
endfunction " }}}}}
