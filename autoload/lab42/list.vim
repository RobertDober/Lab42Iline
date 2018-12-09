" List Object {{
" ***********
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
" }}
"
" List Functions {{
" **************
function! s:add_unique_elements(cache, acc, ele) " {{{{{
  if !has_key(a:cache, a:ele)
    call extend(a:cache, {a:ele: 1})
    call add(a:acc, a:ele)
  endif
  return a:acc
endfunction " }}}}}
function! lab42#list#unique(list) " {{{{{
  return lab42#fn#foldl(a:list, [], function('s:add_unique_elements', [{}]))
endfunction " }}}}}
" }}
"
" List Tools {{
" **********
function! s:splitter_alone(fun, acc, line) " {{{{{
  if call(a:fun, [a:line])
    return extend(a:acc, [[a:line], []])
  else
    call add(a:acc[-1], a:line)
    return a:acc
  endif
endfunction " }}}}}
function! s:splitter_exclude(fun, acc, line) " {{{{{
  if call(a:fun, [a:line])
    return add(a:acc, [])
  else
    call add(a:acc[-1], a:line)
    return a:acc
  endif
endfunction " }}}}}
function! s:splitter_part(fun, acc, line) " {{{{{
  if call(a:fun, [a:line])
    call add(a:acc, [])
  endif
  call add(a:acc[-1], a:line)
  return a:acc
endfunction " }}}}}
function! s:split_impl(list, fun, split) " {{{{{
  if a:split == 0
    return lab42#fn#foldl(a:list, [[]], function('s:splitter_exclude', [a:fun]))
  elseif a:split == 1
    return lab42#fn#foldl(a:list, [[]], function('s:splitter_part', [a:fun]))
  else
    return lab42#fn#foldl(a:list, [[]], function('s:splitter_alone', [a:fun]))
  endif
endfunction " }}}}}
function! lab42#list#split(list, fun, ...) " {{{{{
  let l:split = 0
  if a:0 > 0
    let l:split = a:1
  endif
  return s:split_impl(a:list, a:fun, l:split)
endfunction " }}}}}
" }}
