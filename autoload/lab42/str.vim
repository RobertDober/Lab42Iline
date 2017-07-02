function! lab42#str#startsWith(str, start)
  return match(a:str, '^' . a:start) == 0
endfunction

function! lab42#str#assert_length(length, str)
  if len(a:str) >= a:length
    return a:str
  else
    return a:str . repeat(' ', a:length - len(a:str))
endfunction


function! lab42#str#assure_suffix(str,suffix, ...)
  let l:rgx = a:suffix . '\s*'
  if a:0 > 0
    let l:rgx = a:suffix
    if a:0 > 0
      let l:rgx = '\v' . a:1
    endif
    let l:rgx = '\v' . a:1
  endif
  let l:str = lab42#str#rtrim(a:str)
  if lab42#str#has_suffix(a:str, l:rgx)
    return l:str
  else
    return l:str . a:suffix
  end
endfunction

function! lab42#str#ltrim(str,...)
  let l:trim = '\s*'
  if a:0 > 0
    let l:trim = a:1
  endif
  return substitute(a:str, '\v^' . l:trim, '', '')
endfunction

function! lab42#str#rtrim(str,...)
  let l:trim = '\s*'
  if a:0 > 0
    let l:trim = a:1
  endif
  return substitute(a:str, '\v' . l:trim . '$', '', '')
endfunction

function! lab42#str#trim(str,...)
  let l:trim = '\s*'
  if a:0 > 0
    let l:trim = a:1
  endif
  let l:str = lab42#str#ltrim(a:str, l:trim)
  return lab42#str#rtrim(l:str, l:trim)
endfunction

function! lab42#str#has_infix(str, infix)
  return match(a:str, a:infix) >= 0
endfunction

function! lab42#str#has_suffix(str, suffix)
  return match(a:str, a:suffix . '$') >= 0
endfunction

function! lab42#str#prefix(line)
  return substitute(a:line, '\v\S.*', '', '')
endfunction


function! lab42#str#to_chars(line)
  return map(range(len(a:line)), "strpart('" . substitute(a:line, "'", "''", "g") . "', v:val, 1)")
endfunction
  " function! lab42#str#has_first_word(str, word)
  "   let l:words = split(a:str)
  "   return match(l:words, a:word) >= 0
" endfunction
"
function! lab42#str#get_prefix(str,...)
  let l:prefix='\s*'
  if a:0 > 0
    let l:prefix = a:1
  endif
  return matchstr(a:str, '\v^' . l:prefix)
endfunction

function! lab42#str#get_suffix(str,...)
  let l:suffix='\s*'
  if a:0 > 0
    let l:suffix = a:1
  endif
  return matchstr(a:str, '\v' . l:suffix . '$')
endfunction

function! lab42#str#split_with_prefix(str,...)
  let l:match = call('lab42#str#get_prefix', insert(copy(a:000), a:str))
  return [l:match, strpart(a:str, len(l:match))] 
endfunction

function! lab42#str#split_with_suffix(str,...)
  let l:match = call('lab42#str#get_suffix', insert(copy(a:000), a:str))
  let l:len = len(a:str) - len(l:match)
  return [strpart(a:str, 0, l:len), l:match] 
endfunction

function! lab42#str#replace_part(str, replacement, from, to)
  return strpart(a:str, 0, a:from) . a:replacement . strpart(a:str, a:to)
endfunction
