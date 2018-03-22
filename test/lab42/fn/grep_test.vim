function! TestSimpleGrep()
  let l:list     = ['the', 'quick', 'brown']

  let l:result   = lab42#fn#grep(l:list, '[ei]')
  let l:expected = ['the', 'quick']
  call lab42#test#assert_eq(l:expected, l:result)
endfunction

function! TestSimpleGrepV()
  let l:list     = ['the', '', 'quick', '', 'brown']

  let l:result   = lab42#fn#grep_v(l:list, '[ei]')
  let l:expected = ['', '', 'brown']
  call lab42#test#assert_eq(l:expected, l:result)
endfunction
