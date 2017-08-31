
" Accessing {{{
" The vim macro to create an accessor
" mr"myiw^c$function! s:m(internal)return a:internal._mendfunction/%add accessor%yypkc$let l:methodnames += ['m']^'r 
function! s:head(internal)
  return a:internal._head
endfunction
function! s:tail(internal)
  return call(a:internal._tail, [])
endfunction
" }}}
function! lab42#stream#cons(head, tail)
  let l:wrapper = {}
  let l:object  = {'_head': a:head, '_tail': lab42#fn#memfun(a:tail), '__wrapper': l:wrapper}
  let l:methodnames = []
  let l:methodnames += ['head']
  let l:methodnames += ['tail']
  " %add accessor%
  for l:funname in l:methodnames
    call extend(l:wrapper, {l:funname: funcref('s:' . l:funname, [l:object])})
  endfor
  return l:wrapper
endfunction
