" Sets {{{
function! s:add_both(biset, pair) " {{{{{
  let [l:lhs, l:rhs] = a:biset
  let [l:lele, l:rele] = a:pair
  let l:lhs[l:lele] = l:rele
  let l:rhs[l:rele] = l:lele
  return [l:lhs, l:rhs]
endfunction " }}}}}
function! s:add_element(dict, ele) " {{{{{
  let a:dict[a:ele] = 1
  return a:dict
endfunction " }}}}}
function! s:add_element_with_index(dict, ele_idx) " {{{{{
  let [l:ele, l:idx] = a:ele_idx
  let a:dict[l:ele] = l:idx 
  return a:dict
endfunction " }}}}}
function! s:is_member(dict, ele) " {{{{{
  return has_key(a:dict, a:ele)
endfunction " }}}}}

function! lab42#set#add_element_fn(dict) " {{{{{
  return function('s:add_element', [a:dict])
endfunction " }}}}}
function! lab42#set#biset_from_lists(lhs, rhs) " {{{{{
  let l:pairs = lab42#fn#zip(a:lhs, a:rhs)
  return lab42#fn#foldl(l:pairs, [{}, {}], function('s:add_both'))
endfunction " }}}}}
function! lab42#set#get_left(biset, key) " {{{{{
  let [l:lhs, _] = a:biset
  return get(l:lhs, a:key)
endfunction " }}}}}
function! lab42#set#get_right(biset, key) " {{{{{
  let [_, l:rhs] = a:biset
  return get(l:rhs, a:key)
endfunction " }}}}}
function! lab42#set#is_member_fn(dict) " {{{{{
  return function('s:is_member', [a:dict])
endfunction " }}}}}
function! lab42#set#indexed_set_from_list(list) " {{{{{
  return lab42#fn#foldl_with_index(a:list, {}, funcref('s:add_element_with_index'), 1)
endfunction " }}}}}
function! lab42#set#set_from_list(list) " {{{{{
  return lab42#fn#foldl(a:list, {}, funcref('s:add_element'))
endfunction " }}}}}
" }}}

