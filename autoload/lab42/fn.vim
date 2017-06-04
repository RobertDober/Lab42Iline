"----------------------------------------------------------------------------
" Predefined Fns {{{

function! lab42#fn#nullFn()
endfunction

" Ints {{{{
function! s:adderImpl(...)
  let l:result = 0
  for l:term in copy(a:000)
    let l:result += l:term
  endfor
  return l:result
endfunction

function! lab42#fn#adder()
  if !exists('s:adder')
    let s:adder = function('s:adderImpl')
  endif
  return s:adder
endfunction

function! lab42#fn#inc(...)
  let l:increment = 1
  if a:0 > 0
    let l:increment = a:1
  endif
  return function('s:adderImpl', [l:increment])
endfunction
" }}}}
"
" Strings {{{{
function! s:substituter_prime(str, pat, with, opts)
  return substitute(a:str, a:pat, a:with, a:opts)
endfunction
function! lab42#fn#substituter(pattern, with, ...)
  let l:options = ''
  if a:0 > 0
    let l:options = a:1
  endif
  return lab42#fn#partial_1('s:substituter_prime', '\v' . a:pattern, a:with, l:options)
endfunction
" }}}}
" }}}
" Helpers {{{
" Functional Helpers {{{{
function! lab42#fn#isfn(maybefn)
  return type(a:maybefn) == 2
endfunction
" }}}}

"----------------------------------------------------------------------------
" Dict Helpers {{{{
function! lab42#fn#dict_from_list(list)
  let l:result = {}
  for [l:key, l:val] in a:list
    call extend(l:result, {l:key: l:val})
  endfor
  return l:result
endfunction

function! lab42#fn#get_with_default(dict, key, default)
  if has_key(a:dict, a:key)
    return get(a:dict, a:key)
  else
    if lab42#fn#isfn(a:default)
      return call(a:default, [a:key])
    else
      return a:default
    endif
  endif
endfunction
" }}}
" }}}}

"----------------------------------------------------------------------------
" High Order Functions {{{
" Memoization {{{{

let s:function_memo = {}
function! s:memoize_function(fn)
  let l:repr = string(a:fn)
  let l:memo = s:function_memo[l:repr]
  let l:count = string(l:memo['count'])
  if !has_key(l:memo['values'], l:count)
    let l:memo['values'][l:count] = call(a:fn, [])
  endif
  return l:memo['values'][l:count]
endfunction
function! lab42#fn#memfun(funexp)
  let l:repr     = string(a:funexp)
  if !has_key(s:function_memo, l:repr)
    let s:function_memo[l:repr] = {'count': 0, 'values': {}}
  endif
  let s:function_memo[l:repr]['count'] += 1
  return function('s:memoize_function', [a:funexp])
endfunction
" }}}}

" Some Partial Applications {{{{
function! lab42#fn#partial(funexp, ...)
  return function(a:funexp, copy(a:000))
endfunction

function! s:partial_1_prime(funexp, ...)
  let l:args = copy(a:000)
  let l:first = remove(l:args, -1)
  call insert(l:args, l:first)
  return call(a:funexp, l:args)
endfunction
function! lab42#fn#partial_1(funexp, ...)
  let l:args = copy(a:000)
  call insert(l:args, a:funexp)
  return function('s:partial_1_prime', l:args)
endfunction
" }}}}

" def scan1 {{{{
" scan1 l f acc = foldl l [[], acc] (partial f' f) where
" f' f'' [rl, acc] ele =
"   [add(rl, new), new] where new = (f'' acc ele)
" N.B. We create the closure over f by partial application
function! s:scan1_fprime(funexp, accexp, ele)
  let [l:result, l:acc] = a:accexp
  let l:new             = call(a:funexp, [l:acc, a:ele])

  return [add(l:result, l:new), l:new]
endfunction

function! s:scan1(list, funexp, initial_acc)
  let l:Partial   = function('s:scan1_fprime', [a:funexp])
  let [l:result, _] = lab42#fn#foldl(a:list, [[], a:initial_acc], l:Partial)

  return l:result
endfunction
" }}}}

" def filter {{{{
"filter l f = foldl l [] (partial f' f) where
" f' f'' acc ele = if f'' ele then acc ++ ele else acc end
function! s:filter_prime(funexp, acc, ele)
  if call(a:funexp, [a:ele])
    return add(a:acc, a:ele)
  else
    return a:acc
  endif
endfunction
function! lab42#fn#filter(list, funexp)
  let l:Partial = function('s:filter_prime', [a:funexp])
  return lab42#fn#foldl(a:list, [], l:Partial)
endfunction
" }}}}

" def flatmap {{{{
" flatmap l f = foldl l [] (partial f' f) where
" f' f'' acc ele = acc + fmapped where
" fmapped = if (list (f'' ele)) (f'' ele) else [(f'' ele)]
" }}}}
function! s:flatmap_prime(mapfun, acc, ele)
  let l:map_ele = call(a:mapfun, [a:ele])
  if type(l:map_ele) == 3 " list
    return extend(a:acc, l:map_ele)
  else
    return add(a:acc, l:map_ele)
  endif
endfunction
function! lab42#fn#flatmap(list, funexp)
  return lab42#fn#foldl(a:list, [], function('s:flatmap_prime', [a:funexp]))
endfunction
" def foldl {{{{
function! lab42#fn#foldl(list, acc, funexp)
  let l:result = a:acc
  for l:ele in a:list
    let l:result = call(a:funexp, [l:result, l:ele])
  endfor
  return l:result
endfunction
" }}}}

" def map {{{{
" map l f = foldl l [] (partial f' f) where
" f' f'' acc ele = acc ++ (f'' ele)
" N.B. We create the closure over f by partial application
function! s:map_prime(mapfun, acc, ele)
  let l:newele = call(a:mapfun, [a:ele])
  call add(a:acc, l:newele)
  return a:acc
endfunction
function! lab42#fn#map(list, funexp)
  return lab42#fn#foldl(a:list, [], function('s:map_prime', [a:funexp]))
endfunction
" }}}}

" def map_filter {{{{
function! lab42#fn#map_filter(list, funexp)
  let l:list = copy(a:list)
  let l:mapped = lab42#fn#map(l:list, a:funexp)
  call filter(l:mapped, 'v:val[0]')
  call map(l:mapped, 'v:val[1]')
  return l:mapped
endfunction
" }}}}

" def scan {{{{
function! lab42#fn#scan(list, funexp, ...)
  let l:list = a:list
  if a:0 > 0
    return s:scan1(l:list, a:funexp, a:1)
  elseif empty(l:list)
    return []
  else
    return s:scan1(l:list, a:funexp, l:list[0])
  endif
endfunction
" }}}}

" def zip_with {{{{
" zip_with l f = map l (partial f' f) where
" f' f'' ele = [ele, (f'' ele)]
function! s:zip_with_prime(funexp, ele)
  return [a:ele, call(a:funexp, [a:ele])]
endfunction
function! lab42#fn#zip_with(list, funexp)
  return lab42#fn#map(a:list, function('s:zip_with_prime', [a:funexp]))
endfunction
"}}}}
" }}}
