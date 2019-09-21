function! TestDefaultAroundSpaces() " {{{{{
  let l:subject = "a b"
  let l:expected = "b a"
  let l:result = lab42#string#rotate(l:subject)
  call lab42#test#assert_eq(l:expected, l:result)

  let l:subject = "a  b c"
  let l:expected = "b c  a"
  let l:result = lab42#string#rotate(l:subject)
  call lab42#test#assert_eq(l:expected, l:result)

  " Ignore badly specified case
  let l:subject  = " a  b c"
  let l:expected = "a  b c "
  let l:result   = lab42#string#rotate(l:subject)
  call lab42#test#assert_eq(l:expected, l:result)
endfunction " }}}}}

function! TestOtherDefaults() " {{{{{
  " Hashes are the strongeth
  let l:subject = '"a b" => "c, d"'
  let l:expected = '"c, d" => "a b"'
  let l:result = lab42#string#rotate(l:subject)
  call lab42#test#assert_eq(l:expected, l:result)

  " Then cometh the comma
  let l:subject = '"a;b", "c d"'
  let l:expected = '"c d", "a;b"'
  let l:result = lab42#string#rotate(l:subject)
  call lab42#test#assert_eq(l:expected, l:result)

  " Which is followeth by the ;
  let l:subject = '"a b"; "c d"'
  let l:expected = '"c d"; "a b"'
  let l:result = lab42#string#rotate(l:subject)
  call lab42#test#assert_eq(l:expected, l:result)
endfunction " }}}}}

function! TestAroundOtherStuff() " {{{{{
  let l:subject = "a, b"
  let l:expected = "b, a"
  let l:result = lab42#string#rotate(l:subject, ',\s*')
  call lab42#test#assert_eq(l:expected, l:result)
endfunction " }}}}}

function! TestRotationOrder() " {{{{{
  let l:subject = "a => b => c"
  let l:expected = "b => c => a"
  let l:result = lab42#string#rotate(l:subject, '\s=>\s')

  
  let l:subject = "a => b => c"
  let l:expected = "c => a => b"
  let l:result = lab42#string#rotate(l:subject, ',\s=>\s', 'right')
endfunction " }}}}}
