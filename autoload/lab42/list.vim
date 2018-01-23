
" Methods {{{
" =======
" Accessors  {{{{
" ---------
function! s:get(list, index, ...) " {{{{{
  let l:default = 0
  if a:0 > 0
    let l:default = a:1
  endif
  if a:index >= a:list.__len
    return l:default
  elseif abs(a:index) > a:list.__len
    return l:default
  else
    return a:list.__list[a:index]
  endif
endfunction " }}}}}

function! s:first(list, ...) " {{{{{
  return call('s:get', extend([a:list, 0], a:000)) 
endfunction " }}}}}
function! s:second(list, ...) " {{{{{
  return call('s:get', extend([a:list, 1], a:000)) 
endfunction " }}}}}
function! s:last(list, ...) " {{{{{
  return call('s:get', extend([a:list, -1], a:000)) 
endfunction " }}}}}
" }}}}
" Constructors {{{{
" ------------
function! lab42#list#new(elements) " {{{{{
  let l:wrapper = {}
  let l:object  = {'__list': a:elements, '__len': len(a:elements), '__wrapper': l:wrapper}
  let l:methodnames = ['get']
  let l:methodnames += ['first', 'last', 'second']
  " %add accessor%
  for l:funname in l:methodnames
    call extend(l:wrapper, {l:funname: funcref('s:' . l:funname, [l:object])})
  endfor
  return l:wrapper
endfunction " }}}}}
" }}}}
" }}}
