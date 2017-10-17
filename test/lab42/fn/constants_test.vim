function! TestTrueAndTrueFn()
  call lab42#test#assert_eq(1, lab42#fn#true())
  call lab42#test#assert_eq(1, call(lab42#fn#true_fn(), []))
endfunction

function! TestDefaultPaddingSubstrAndSubstrFn()
  call lab42#test#assert_eq('bc', lab42#fn#substr(2, 3, 'abcd'))

  let l:strings = [ 'alpha', 'ab', '', 'beta']
  let l:Subs    = lab42#fn#substr_fn(2, 4)
  let l:expected = [ 'lph', 'b  ', '   ', 'eta']
  call lab42#test#assert_eq(l:expected, lab42#fn#map(l:strings, l:Subs))
endfunction

function! TestExplicitPaddingSubstrAndSubstrFn()
  call lab42#test#assert_eq('bc', lab42#fn#substr(2, 3, ' ', 'abcd'))
  call lab42#test#assert_eq('bcd.', lab42#fn#substr(2, 5, '.+', 'abcd'))

  let l:strings = [ 'alpha', 'ab', '', 'beta']
  let l:Subs    = lab42#fn#substr_fn(2, 5, '.-')
  let l:expected = [ 'lpha', 'b.-.', '.-.-', 'eta.']
  call lab42#test#assert_eq(l:expected, lab42#fn#map(l:strings, l:Subs))
endfunction
