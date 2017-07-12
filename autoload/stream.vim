" Methods {{{
"------------
function! s:head(stream)
  return a:stream._head
endfunction
function! s:tail(stream)
  return a:stream._tail()
endfunction
function! s:delayed_tail(stream)
  return a:stream._tail
endfunction
" }}}
" Convenience {{{{
function! s:cycle_prime(current, original) " {{{{{
  if a:current.is_empty()
    return s:cycle_prime(a:original, a:original)
  else
    let l:next = a:current.tail()
    return stream#cons(a:current.head(), funcref('s:cycle_prime', [l:next, a:original]))
  endif
endfunction " }}}}}
function! s:cycle(stream)  dict " {{{{{
  if a:stream._empty
    return stream#empty()
  else
    return s:cycle_prime(self, self)
  endif
endfunction " }}}}}

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
function! s:drop_until(_stream, funref) dict " {{{{{
  let l:stream = self
  while 1
    if l:stream.is_empty()
      return l:result
    endif
    let l:head = l:stream.head()
    if call(a:funref, [l:head])
      return l:stream
    endif
    let l:stream = l:stream.tail()
  endwhile
endfunction " }}}}}
function! s:drop_while(_stream, funref) dict " {{{{{
  let l:stream = self
  while 1
    if l:stream.is_empty()
      return l:result
    endif
    let l:head = l:stream.head()
    if !call(a:funref, [l:head])
      return l:stream
    endif
    let l:stream = l:stream.tail()
  endwhile
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
function! s:take_until(_stream, funref) dict " {{{{{
  let l:stream = self
  let l:result = []
  while 1
    if l:stream.is_empty()
      return l:result
    endif
    let l:head = l:stream.head()
    if call(a:funref, [l:head])
      return l:result
    else
      call add(l:result, l:head)
    endif
    let l:stream = l:stream.tail()
  endwhile
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
" High Order  {{{{
function! s:delayed_map(delayed_tail, funref)
  let l:tail = a:delayed_tail()
  return l:tail.map(a:funref)
endfunction
function! s:map1(stream, funref) " {{{{{
  let l:mapped_head  = a:funref(a:stream._head)
  " a fn that, when called will return s:map(self.tail(), a:funref)
  return stream#cons(l:mapped_head, funcref('s:delayed_map', [a:stream._tail, a:funref]))
endfunction " }}}}}
function! s:map(stream, funref) " {{{{{
  if a:stream._empty
    return a:stream
  endif
  return s:map1(a:stream, a:funref)
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
  let l:methodnames = ['head', 'tail', 'delayed_tail', 'is_empty']
  let l:methodnames += ['all', 'cycle', 'drop', 'drop_until', 'drop_while']
  let l:methodnames += ['map', 'take', 'take_until', 'take_while']
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
