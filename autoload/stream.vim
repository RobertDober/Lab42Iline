" Methods {{{
"------------
function! s:head(stream)
  return a:stream._head
endfunction
function! s:tail(stream)
  return a:stream._tail()
endfunction
" }}}
" Convenience {{{{
function! s:drop(_stream, n) dict " {{{{{
  let l:stream = self
  for l:i in range(a:n)
    if l:stream.is_empty()
      return l:stream
    endif
    let l:stream = l:stream.tail()
  endfor
  return l:stream
endfunction " }}}}}
function! s:take(_stream, n) dict " {{{{{
  let l:stream = self
  let l:result = []
  for l:i in range(a:n)
    if l:stream.is_empty()
      return l:result
    endif
    call add(l:result, l:stream.head())
    let l:stream = l:stream.tail()
  endfor
  return l:result
endfunction " }}}}}
function! s:take_while(_stream, funref) dict " {{{{{
  let l:stream = self
  let l:result = []
  while 1
    if l:stream.is_empty()
      return l:result
    endif
    let l:head = l:stream.head()
    if call(a:funref, [l:head])
      call add(l:result, l:head)
    else
      return l:result
    endif
    let l:stream = l:stream.tail()
  endwhile
  return l:result
endfunction " }}}}}
function! s:all(_stream) dict " {{{{{
  return self.take_while(funcref('lab42#fn#true'))
endfunction " }}}}}
" }}}}
" Basic Functions {{{
" -------------------
"  Emptyness {{{{
function! s:empty()
  return stream#cons(0,0)
endfunction " }}}}}
function! s:is_empty(stream) " {{{{{
  return a:stream._tail == 0
endfunction " }}}}}
function! stream#empty() " {{{{{
  return stream#cons(0, 0)
endfunction " }}}}}
function! stream#make_empty()
  return funcref('s:empty')
endfunction
" }}}}

" Construction {{{{
function! stream#cons(head, tail) " {{{{{
  if type(a:tail) == 0 " number
    let l:object =  {'_head': a:head, '_tail': 0, '_empty': 1}
  else
    let l:object =  {'_head': a:head, '_tail': lab42#fn#memfun(a:tail), '_empty': 0}
  endif
  let l:wrapper = {}
  let l:methodnames = ['head', 'tail', 'is_empty']
  let l:methodnames += ['all', 'drop', 'take', 'take_while']
  for l:funname in l:methodnames
    call extend(l:wrapper, {l:funname: funcref('s:' . l:funname, [l:object])})
  endfor
  return l:wrapper
endfunction " }}}}}

function! stream#finite(from) " {{{{{
  if empty(a:from)
    return stream#empty()
  endif
  return stream#cons(a:from[0], funcref('stream#finite', [a:from[1:]]))
endfunction " }}}}}
" }}}}


" }}}
