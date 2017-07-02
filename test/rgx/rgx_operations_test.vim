let s:rgx = lab42#rgx#new('<a(.*)a>')

function! TestMatchIndices()
  "                     0....+....1....+....2
  call s:rgx.match_with('. alpha centauri')
  call lab42#test#assert_eq([2, 7], s:rgx.match_indices)
endfunction

function! TestReplaceAll()
  call s:rgx.match_with(' alpha centauri')
  call s:rgx.replace_match('beta')
  call lab42#test#assert_eq(' beta centauri', s:rgx.last_subject)
endfunction


