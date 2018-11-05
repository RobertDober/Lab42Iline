function! s:add1(a) " {{{{{
  return a:a + 1
endfunction " }}}}}

function! TestConstructWithFunction() " {{{{{
  let l:app = lab42#app#new(function('s:add1'))

  call lab42#test#assert_eq(2,l:app.call([1]))
  call lab42#test#assert_eq(2,l:app.call1(1))
endfunction " }}}}}

function! TestConstructWithString() " {{{{{
  let l:app = lab42#app#new('lab42#fn#add', [1])
  
  call lab42#test#assert_eq(2,l:app.call([1]))
  call lab42#test#assert_eq(2,l:app.call1(1))
endfunction " }}}}}
