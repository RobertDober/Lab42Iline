function! s:vowel(matches) " {{{{{
  return "vowel: " . a:matches[2]
endfunction " }}}}}
function! s:consonant(matches) " {{{{{
  return "consonant: " . a:matches[2]
endfunction " }}}}}

let s:vow = function("s:vowel")
let s:con = function("s:consonant")

function! s:match_vc(str) " {{{{{
  return lab42#match#match(a:str,
    \ ['\v^([aeiou])(.)', s:vow], 
    \ ['\v^(.)(.)', s:con])
endfunction " }}}}}

function! TestSimpleCase() " {{{{{
  let result   = s:match_vc("ab")
  let expected = "vowel: b"
  call lab42#test#assert_eq(expected, result)

  let result   = s:match_vc("ba")
  let expected = "consonant: a"
  call lab42#test#assert_eq(expected, result)
endfunction " }}}}}

function! TestTestWithStringAction() " {{{{{
  let l:result   = lab42#match#match("ab",
                                    \ ['^\v(a)(.)', 'lab42#list#new'])
  call lab42#test#assert_eq("ab", l:result.first())
  call lab42#test#assert_eq("", l:result.last())
endfunction " }}}}}
function! TestTestWithStringAction() " {{{{{
  let l:result   = lab42#match#match_only("ab",
                                    \ ['^\v(a)(.)', 'lab42#list#new'])
  call lab42#test#assert_eq("ab", l:result.first())
  call lab42#test#assert_eq("b", l:result.last())
endfunction " }}}}}
