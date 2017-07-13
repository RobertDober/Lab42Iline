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
function! s:delayed_filter(delayed_tail, funref) " {{{{{
  return a:delayed_tail().filter(a:funref)
endfunction
function! s:filter2(stream, funref)
  let l:stream = a:stream.drop_until(a:funref)
  return l:stream.filter(a:funref) " will go into else brunch in s:filter1, so no endless rec
endfunction
function! s:filter1(stream, funref)
  if !a:funref(a:stream._head)
    return s:filter2(a:stream._tail(), a:funref)
  else
    return stream#cons(a:stream._head, funcref('s:delayed_filter', [a:stream._tail, a:funref]))
  endif
endfunction
function! s:filter(stream, funref) dict
  if a:stream._empty
    return self
  endif
  return s:filter1(a:stream, a:funref)
endfunction " }}}}}

function! s:delayed_map(delayed_tail, funref) " {{{{{
  let l:tail = a:delayed_tail()
  return l:tail.map(a:funref)
endfunction
function! s:map1(stream, funref)
  let l:mapped_head  = a:funref(a:stream._head)
  " a fn that, when called will return s:map(self.tail(), a:funref)
  return stream#cons(l:mapped_head, funcref('s:delayed_map', [a:stream._tail, a:funref]))
endfunction
function! s:map(stream, funref) dict
  if a:stream._empty
    return self
  endif
  return s:map1(a:stream, a:funref)
endfunction " }}}}}

function! s:delayed_reject(delayed_tail, funref) " {{{{{
  return a:delayed_tail().reject(a:funref)
endfunction
function! s:reject2(stream, funref)
  let l:stream = a:stream.drop_while(a:funref)
  return l:stream.reject(a:funref) " will go into else brunch in s:reject1, so no endless rec
endfunction
function! s:reject1(stream, funref)
  if a:funref(a:stream._head)
    return s:reject2(a:stream._tail(), a:funref)
  else
    return stream#cons(a:stream._head, funcref('s:delayed_reject', [a:stream._tail, a:funref]))
  endif
endfunction
function! s:reject(stream, funref) dict
  if a:stream._empty
    return self
  endif
  return s:reject1(a:stream, a:funref)
endfunction " }}}}}
" }}}}

" Basic Functions {{{
" -------------------
"  Emptyness {{{{
function! s:empty()
  return stream#cons(0,0)
endfunction " }}}}}
function! s:is_empty(stream) " {{{{{
  return a:stream._empty 
endfunction " }}}}}
function! stream#empty() " {{{{{
  if !exists('s:the_empty_stream')
    let s:the_empty_stream = stream#cons(0, 0)
  endif
  return s:the_empty_stream
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
  let l:methodnames += ['map', 'filter', 'reject', 'take', 'take_until', 'take_while']
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

function! s:delayed_combine(...) " {{{{{
  let l:all     = copy(a:000)
  let l:streams = l:all[1:]
  let l:tails   = map(l:streams, 'v:val.tail()')
  let l:params  = insert(l:tails, a:1)
  return call('stream#combine', l:params)
endfunction
function! s:combine1(...)
  let l:all     = copy(a:000)
  let l:streams = l:all[1:]
  let l:heads   = map(l:streams, 'v:val.head()')
  let l:head    = call(a:1, l:heads) 
  return stream#cons(l:head, funcref('s:delayed_combine', l:all)) 
endfunction
function! stream#combine(...)
  let l:all     = copy(a:000)
  let l:streams = l:all[1:]
  if empty(filter(l:streams, 'v:val.is_empty()')) 
    return call('s:combine1', l:all)
  else
    return stream#empty()
  endif
endfunction " }}}}}

function! stream#const_stream(element) " {{{{{
  return stream#cons(a:element, funcref('stream#const_stream', [a:element])) 
endfunction " }}}}}
" }}}}
" }}}
