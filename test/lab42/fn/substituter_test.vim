
function! TestSubstituteAll()
  let l:Subs = lab42#fn#substituter('[a-h]', '*', 'g')

  call lab42#test#assert_eq('**llo', call(l:Subs, ['hello']))
  call lab42#test#assert_eq('***llo', call(l:Subs, ['bhello']))
endfunction

function! TestSubstituteAtBeg()
  let l:Subs = lab42#fn#substituter('^[a-e]', '*')

  call lab42#test#assert_eq('hello', call(l:Subs, ['hello']))
  call lab42#test#assert_eq('*hello', call(l:Subs, ['bhello']))
endfunction

function! TestSubstitute()
  let l:Subs = lab42#fn#substituter('[hl]', '*')

  call lab42#test#assert_eq('*ello', call(l:Subs, ['hello']))
  call lab42#test#assert_eq('be*lo', call(l:Subs, ['bello']))
endfunction
