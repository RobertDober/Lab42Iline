
function! TestOption()
  let l:some = lab42#data#some(42)
  call lab42#test#assert_eq(42, l:some.val())
  call lab42#test#assert_eq(1, l:some.some())
  call lab42#test#assert_eq(0, l:some.none())

  let l:none = lab42#data#none()
  call lab42#test#assert_eq(1, l:none.none())
  call lab42#test#assert_eq(0, l:none.some())
endfunction
