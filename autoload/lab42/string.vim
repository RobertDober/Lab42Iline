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
function! lab42#string#rotate(str) " {{{{{
  let l:sep = '\v\s+'
  let l:parts = lab42#string#split(a:str, l:sep)
    call lab42#test#dgb(l:parts)
  if len(l:parts) > 2
    let l:out   = extend(l:parts[2:], [l:parts[1], l:parts[0]])
    " call lab42#test#dgb(l:out)
    return join(l:out)
  else
    return a:str
  endif
endfunction " }}}}}
" }}}}
