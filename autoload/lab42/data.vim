" mr"myiw^c$function! s:m(internal)return a:internal._mendfunction/%add accessor%yypkc$let l:methodnames += ['m']^'r 
" Accessors {{{
function! s:some(internal)
  return a:internal._some
endfunction
function! s:none(internal)
  return !a:internal._some
endfunction
function! s:val(internal)
  return a:internal._val
endfunction
" }}}
" Construction {{{
function! lab42#data#none()
  return s:constructor(0,0)
endfunction
function! lab42#data#some(val)
  return s:constructor(1, a:val)
endfunction
function! s:constructor(some, val)
  let l:wrapper = {}
  let l:object  = {'__wrapper': l:wrapper, '_some': a:some, '_val': a:val} 

  let l:methodnames = []
  let l:methodnames += ['some']
  let l:methodnames += ['none']
  let l:methodnames += ['val']
  " %add accessor%
  for l:funname in l:methodnames
    call extend(l:wrapper, {l:funname: funcref('s:' . l:funname, [l:object])})
  endfor
  return l:wrapper
endfunction " }}}
