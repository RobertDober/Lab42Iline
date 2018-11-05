" {{{{ CARTHESIAN
function! s:carth_prod(lists) " {{{{{
  if len(a:lists) == 2
    return s:carth_prod2(a:lists)
  endif
  let l:list  = a:lists[0]
  let l:prods = s:carth_prod(a:lists[1:])

  let l:result = []
  for l:ele in l:list
    for l:prod in l:prods
      call add(l:result, insert(copy(l:prod), l:ele))
    endfor
  endfor
  return l:result
endfunction " }}}}}

function! s:carth_prod2(lists) " {{{{{
  let [l:lft, l:rgt] = a:lists
  let l:result = []
  for l:l in l:lft
    for l:r in l:rgt
      call add(l:result, [l:l, l:r])
    endfor
  endfor
  return l:result
endfunction " }}}}}

function! s:extract_from(dir, key) " {{{{{
  return a:dir[a:key]
endfunction " }}}}}

function! s:map_with_keys(keyorder, tuple) " {{{{{
  let l:pairs = lab42#fn#zip(a:keyorder, a:tuple)
  return lab42#fn#foldl(l:pairs, {}, lab42#fn#add_pair_to_dir_fn())
endfunction " }}}}}

function! lab42#dir#carthesian(dir,keyorder) " {{{{{
  let l:values = lab42#fn#map(a:keyorder, function('s:extract_from', [a:dir]))
  let l:prod   = s:carth_prod(l:values)
  return lab42#fn#map(l:prod, function('s:map_with_keys', [a:keyorder]))
endfunction " }}}}}
" }}}}

" {{{{ ZIP
fun s:add_nth_value_of_key(dir, idx, result, key)
  try
    call extend(a:result, {a:key: a:dir[a:key][a:idx]})
  finally " takes care of shorter lists if not all lists have equal length
    return a:result
  endtry
endfunction

function! s:take_nth_of_all(dir, keys, idx) " {{{{{
  return lab42#fn#foldl(a:keys, {}, function('s:add_nth_value_of_key', [a:dir, a:idx]))
endfunction " }}}}}

function! lab42#dir#zip(dir) " {{{{{
  let l:keys   = keys(a:dir)
  let l:guide  = l:keys[0]
  return lab42#fn#map(range(len(a:dir[l:guide])), function('s:take_nth_of_all', [a:dir, l:keys]))
endfunction " }}}}}
" }}}}
