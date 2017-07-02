let s:rgx = lab42#rgx#new('<a.*a>')

function! TestRgxConstruction()
  call lab42#test#assert_eq(0, s:rgx.matched)
  call lab42#test#assert_eq([], s:rgx.matches)
  call lab42#test#assert_eq('<a.*a>', s:rgx.rgx)
  call lab42#test#assert_eq(0, s:rgx.last_subject)
endfunction

function! TestBasicMatching()
  call s:rgx.match_with('hello')
  call lab42#test#assert_eq(0, s:rgx.matched)
  call lab42#test#assert_eq('<a.*a>', s:rgx.rgx)
  call lab42#test#assert_eq('<a.*a>', s:rgx.rgx)
  call lab42#test#assert_eq('hello', s:rgx.last_subject)

  call s:rgx.match_with(' alpha centauri')
  call lab42#test#assert_eq(['alpha', '', ''], s:rgx.matches[0:2])
  call lab42#test#assert_eq('alpha', s:rgx.matched)
  call lab42#test#assert_eq('<a.*a>', s:rgx.rgx)
  call lab42#test#assert_eq(' alpha centauri', s:rgx.last_subject)

  call s:rgx.match_with('halla')
  call lab42#test#assert_eq(0, s:rgx.matched)
  call lab42#test#assert_eq('<a.*a>', s:rgx.rgx)
  call lab42#test#assert_eq('<a.*a>', s:rgx.rgx)
  call lab42#test#assert_eq('halla', s:rgx.last_subject)
endfunction
