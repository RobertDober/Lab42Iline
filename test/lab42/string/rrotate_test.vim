function! TestDefaultAroundSpaces() " {{{{{
  let l:subject = "a b"
  let l:expected = "b a"
  let l:result = lab42#string#rrotate(l:subject)
  call lab42#test#assert_eq(l:expected, l:result)

  let l:subject = "a  b c"
  let l:expected = "c a  b"
  let l:result = lab42#string#rrotate(l:subject)
  call lab42#test#assert_eq(l:expected, l:result)
endfunction " }}}}}

function! TestOtherDefaults() " {{{{{
  " Hashes are the strongeth
  let l:subject = '"a b" => "c, d"'
  let l:expected = '"c, d" => "a b"'
  let l:result = lab42#string#rrotate(l:subject)
  call lab42#test#assert_eq(l:expected, l:result)

  " Then cometh the comma
  let l:subject = '"a;b", "c d"'
  let l:expected = '"c d", "a;b"'
  let l:result = lab42#string#rrotate(l:subject)
  call lab42#test#assert_eq(l:expected, l:result)

  " Which is followeth by the ;
  let l:subject = '"a b"; "c d"'
  let l:expected = '"c d"; "a b"'
  let l:result = lab42#string#rrotate(l:subject)
  call lab42#test#assert_eq(l:expected, l:result)

  "it really rotates to the right
  let l:subject = 'a;b;c'
  let l:expected = 'c;a;b'
  let l:result = lab42#string#rrotate(l:subject)
  call lab42#test#assert_eq(l:expected, l:result)
endfunction " }}}}}

function! TestExplicit() " {{{{{
  let l:subject = 'a-b-c'
  let l:expected = 'c-a-b'
  let l:result = lab42#string#rrotate(l:subject, '-')
  call lab42#test#assert_eq(l:expected, l:result)
  
endfunction " }}}}}

