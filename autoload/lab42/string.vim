" Heuristic determination of split {{{{
function! s:find_sep(str) " {{{{{
  if match(a:str, '=>') > 0
    return '\s*=>\s*'
  endif
  if match(a:str, ',') > 0
    return ',\s*'
  endif
  if match(a:str, ';') > 0
    return ';\s*'
  endif
  return '\s\+'
endfunction " }}}}}
" }}}}
" Splitting {{{{
function! lab42#string#split(subject, pat) " {{{{{
  let l:result = []
  let l:subject = a:subject
  while  1
    let [l:matched, l:start, l:end] = matchstrpos(l:subject, a:pat)
    " call lab42#test#dbg([l:subject, l:matched, l:start, l:end])
    if l:start < 0
      if empty(l:subject)
        return l:result
      else
        return add(l:result, l:subject)
      endif
    else
      call add(l:result, strpart(l:subject, 0, l:start))
      call add(l:result, l:matched)
      let l:subject = strpart(l:subject, l:end)
    endif
  endwhile
  return l:result
endfunction " }}}}}
" }}}}
" String Rotation {{{{
function! lab42#string#rotate(str, ...) " {{{{{
  if a:0 > 0
    let l:sep = a:1
  else
    let l:sep = s:find_sep(a:str)
  endif
  if a:0 > 1 
    if a:2 == 'right'
      return lab42#string#rrotate(a:str, l:sep)
    endif
  endif
  return lab42#string#lrotate(a:str, l:sep)
endfunction " }}}}}
function! lab42#string#lrotate(str, sep) " {{{{{
  let l:parts = lab42#string#split(a:str, a:sep)
  if len(l:parts) > 2
    let l:out   = extend(l:parts[2:], [l:parts[1], l:parts[0]])
    return join(l:out, '')
  else
    return a:str
  endif
endfunction " }}}}}
function! lab42#string#rrotate(str, ...) " {{{{{
  if a:0
    let l:sep = a:1
  else
    let l:sep = s:find_sep(a:str)
  endif
  let l:parts = lab42#string#split(a:str, l:sep)
  if len(l:parts) > 2
    let l:out   = insert(insert(l:parts[0:-3], l:parts[-2]), l:parts[-1]) 
    return join(l:out, '')
  else
    return a:str
  endif
  
endfunction " }}}}}

function! lab42#string#tokens(line, tokens) " {{{{{
  let l:graphemes = split(a:line, '\s*')
  let l:tokens    = split(a:tokens, '\s*')
  let l:set       = lab42#set#set_from_list(l:tokens) 
  return lab42#fn#filter(l:graphemes, lab42#set#is_member_fn(l:set)) 
endfunction " }}}}}
" }}}}
