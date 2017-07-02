
" Methods {{{
" --------------------------------------------------------
function s:match_with(subject) dict
  let self.last_subject = a:subject
  let self.matches = matchlist(a:subject, '\v'. self.rgx)
  if empty(self.matches)
    let self.matched = 0
  else
    let self.matched = self.matches[0]
    let [_, l:start, l:end] = matchstrpos(a:subject, '\v' . self.rgx)
    let self.match_indices = [l:start, l:end]
  endif
endfunction

function s:replace_match(with) dict
  let self.last_subject = strpart(self.last_subject, 0, self.match_indices[0]) . \
  a:with . \
  strpart(self.last_subject, self.match_indices[1])
  return self.last_subject
endfunction
" }}}

" Initialisation {{{
" --------------------------------------------------------
function! lab42#rgx#new(rgx)
  let l:rgx = { 'rgx': a:rgx, 'matches': [], 'matched': 0, 'last_subject': 0 }
  let l:rgx.match_with = function('s:match_with')
  return l:rgx
endfunction
" }}}


