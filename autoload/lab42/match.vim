" Matching {{{
function! s:execute_action(match, action) " {{{{{
  return call(a:action, [a:match])
endfunction " }}}}}
function! lab42#match#match(str, ...) " {{{{{
  for l:pair in a:000
    let l:match = matchlist(a:str, l:pair[0])
    if !empty(l:match)
      return s:execute_action(l:match, l:pair[1])
    endif
  endfor
endfunction " }}}}}
function! lab42#match#match_only(str, ...) " {{{{{
  for l:pair in a:000
    let l:match = lab42#fn#reject(matchlist(a:str, l:pair[0]), lab42#fn#empty_fn())
    if !empty(l:match)
      return s:execute_action(l:match, l:pair[1])
    endif
  endfor
endfunction " }}}}}
" }}}
