"
"  Applications
"  ============
"
"  Object Model Implementation
"
"  The constructor returns a `wrapper` object which is an object containing
"  all methods.
"
"  Each method is a curried function with the _real_ `object` as first param.
"  This _real_ `object` contains all the data and is completely opaque as it
"  is not exposed at all by the constructor.
"
"  For the convenience of methods the `wrapper` object is referenced from the
"  _real_ object by the `__wrapper` key.

" Accessors  {{{{
" ---------
function! s:call(app, args) " {{{{{
  let l:args = copy(a:app.__args)
  call extend(l:args, a:args)
  return call(a:app.__fun, l:args)
endfunction " }}}}}
function! s:call1(app, arg) " {{{{{
  let l:args = copy(a:app.__args)
  call add(l:args, a:arg)
  return call(a:app.__fun, l:args)
endfunction " }}}}}
" }}}}

" Constructors {{{{
" ------------
function! lab42#app#new(fun, ...) " {{{{{
  let l:args = []
  if a:0
    let l:args = a:1
  endif
  
  if type(a:fun) == 1 " String
    let l:Fun = function(a:fun)
  else
    let l:Fun = a:fun
  endif
  let l:wrapper = {}
  let l:object  = {'__fun': l:Fun, '__args': l:args, '__wrapper': l:wrapper}
  let l:methodnames =  []
  let l:methodnames += ['call', 'call1']
  " %add accessor%
  for l:funname in l:methodnames
    call extend(l:wrapper, {l:funname: funcref('s:' . l:funname, [l:object])})
  endfor
  return l:wrapper
endfunction " }}}}}

" Modulefunctions {{{{
" ---------------
function! s:apply(args, fun) " {{{{{
  return a:fun.call(a:args)
endfunction " }}}}}
function! lab42#app#map(list_of_apps, ...) " {{{{{
  let l:args = copy(a:000)
  call lab42#test#dbg(l:args)
  return lab42#fn#map(a:list_of_apps, function('s:apply', [l:args]))
endfunction " }}}}}

function! s:folder1(acc, app) " {{{{{
  return a:app.call([a:acc])
endfunction " }}}}}
function! lab42#app#foldl1(apps, acc) " {{{{{
  return lab42#fn#foldl(a:apps, a:acc, function('s:folder1'))
endfunction " }}}}}
" }}}}
