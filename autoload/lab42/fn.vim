if exists('g:lab42_fn_autoloaded')
  finish
endif
let g:lab42_fn_autoloaded = 1
"----------------------------------------------------------------------------
" Predefined Fns {{{

function! lab42#fn#nullFn()
endfunction


" Consts {{{{
function! lab42#fn#empty(x)
  return empty(a:x)
endfunction
function! lab42#fn#empty_fn()
  return funcref('lab42#fn#empty')
endfunction
function! lab42#fn#false(...)
  return 0
endfunction
function! lab42#fn#false_fn()
  return funcref('lab42#fn#false')
endfunction
function! lab42#fn#true(...)
  return 1
endfunction
function! lab42#fn#true_fn()
  return funcref('lab42#fn#true')
endfunction
function! lab42#fn#identity(anything)
  return a:anything
endfunction
function! lab42#fn#id_fn()
  return funcref('lab42#fn#identity')
endfunction
" }}}}
" Bools {{{{
function! s:not(funexp, ...)
  return !call(a:funexp, copy(a:000))
endfunction
function! lab42#fn#negate(funexp)
  return function('s:not', [a:funexp])
endfunction
" }}}}
" Ints {{{{
" Operations {{{{{
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
function! lab42#fn#add_fn()
  return lab42#fn#adder()
endfunction

function! lab42#fn#inc(...)
  let l:increment = 1
  if a:0 > 0
    let l:increment = a:1
  endif
  return function('s:adderImpl', [l:increment])
endfunction

function! s:multiply(rhs, lhs)
  return a:lhs * a:rhs
endfunction
function! lab42#fn#mult_fn(rhs)
  return funcref('s:multiply', [a:rhs])
endfunction
function! s:subtract(lhs, rhs)
  return a:lhs - a:rhs
endfunction
function! lab42#fn#sub_fn(...)
  return funcref('s:subtract', copy(a:000))
endfunction
function! s:rev_subtract(rhs, lhs)
  return a:lhs - a:rhs
endfunction
function! lab42#fn#rev_sub_fn(...)
  return funcref('s:rev_subtract', copy(a:000))
endfunction
" Predicates {{{{{
function! lab42#fn#even(n)
  return a:n % 2 == 0
endfunction
function! lab42#fn#even_fn()
  return funcref('lab42#fn#even')
endfunction
function! lab42#fn#odd(n)
  return a:n % 2 == 1
endfunction
function! lab42#fn#odd_fn()
  return funcref('lab42#fn#odd')
endfunction
" }}}}}
" Comparers {{{{{
function! s:less_than(rhs, lhs)
  return a:lhs < a:rhs
endfunction
function! lab42#fn#less_fn(rhs)
  return funcref('s:less_than', [a:rhs])
endfunction
function! s:greater_than(rhs, lhs)
  return a:lhs > a:rhs
endfunction
function! lab42#fn#greater_fn(rhs)
  return funcref('s:greater_than', [a:rhs])
endfunction
" }}}}}
" }}}}
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

function! s:matcher_prime(str, with)
  return match(a:str, '\v' . a:with) >= 0
endfunction
function! lab42#fn#matcher(with)
  return lab42#fn#partial_1('s:matcher_prime', a:with)
endfunction
" }}}}
" }}}
" Lists {{{{
function! lab42#fn#islist(maybelist)
  return type(a:maybelist) == 3
endfunction
function! lab42#fn#make_list(...)
  return copy(a:000)
endfunction
function! s:list_shorter_than(len, list)
  return len(a:list) < a:len
endfunction
function! lab42#fn#list_shorter_than_fn(len)
  return funcref('s:list_shorter_than', [a:len])
endfunction
function! lab42#fn#get_ele(list, ele)
  return get(a:list, a:ele)
endfunction
function! lab42#fn#get_ele_fn(ele)
  return lab42#fn#partial_1(function('lab42#fn#get_ele'), a:ele)
endfunction
" }}}}
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
function! s:memfun(funexp) dict
  if ! self.invoked
    let self.invoked = 1
    let self.result = a:funexp()
  endif
  return self.result
endfunction

function! lab42#fn#memfun(funexp)
  return function('s:memfun', [a:funexp], {'invoked': 0})
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
function! lab42#fn#filter_with_index(list, funexp, ...)
  let l:start = 0
  let l:incr  = 1
  if a:0 > 0
    let l:start = a:1
  endif
  if a:0 > 1
    let l:incr = a:2
  endif
  let l:Partial = function('s:filter_prime', [a:funexp])
  return lab42#fn#foldl_with_index(a:list, [], l:Partial, l:start, l:incr)
endfunction
" }}}}
"
" def reject {{{{
" reject l f = folfl l [] (partial f' f) where
" f' f'' acc ele = if f'' ele then acc else acc ++ ele end
function! s:reject_prime(funexp, acc, ele)
  if call(a:funexp, [a:ele])
    return a:acc
  else
    return add(a:acc, a:ele)
  endif
endfunction
function! lab42#fn#reject(list, funexp)
  let l:Partial = function('s:reject_prime', [a:funexp])
  return lab42#fn#foldl(a:list, [], l:Partial)
endfunction
function! lab42#fn#reject_with_index(list, funexp, ...)
  let l:start = 0
  let l:incr  = 1
  if a:0 > 0
    let l:start = a:1
  endif
  if a:0 > 1
    let l:incr = a:2
  endif
  let l:Partial = function('s:reject_prime', [a:funexp])
  return lab42#fn#foldl_with_index(a:list, [], l:Partial, l:start, l:incr)
endfunction
" }}}}
" def find {{{{
function! s:find_prime(funexp, _acc, ele)
  return call(a:funexp,[a:ele])
endfunction
function! lab42#fn#find(list, funexp)
  for l:ele in a:list
    let l:val = call(a:funexp, [l:ele])
    if l:val.some()
      return l:val
    endif
  endfor
  return lab42#data#none()
endfunction
" }}}}


" def flatmap {{{{
" flatmap l f = foldl l [] (partial f' f) where
" f' f'' acc ele = acc + fmapped where
" fmapped = if (list (f'' ele)) (f'' ele) else [(f'' ele)]
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
" }}}}
" def foldl {{{{
function! lab42#fn#foldl(list, acc, funexp)
  let l:result = a:acc
  for l:ele in a:list
    let l:result = call(a:funexp, [l:result, l:ele])
  endfor
  return l:result
endfunction
" }}}}
" def foldl_with_index {{{{
" foldl_with_index l a f =
"   foldl l [a, 0] (partial f' f) where
"   f' f'' [a', i] e = [(f a [e, i]), i + 1]
function! s:foldl_with_index_prime(incr, original_f, acc, ele) "  ==  f'
  let [l:acc, l:idx] = a:acc
  let l:new_acc = call(a:original_f, [l:acc, [a:ele, l:idx]])
  return [l:new_acc, l:idx+a:incr]
endfunction
function! lab42#fn#foldl_with_index(list, acc, funexp, ...)
  let l:start = 0
  let l:incr  = 1
  if a:0 > 0
    let l:start = a:1
  endif
  if a:0 > 1
    let l:incr = a:2
  endif
  return lab42#fn#foldl(a:list, [a:acc, l:start], function('s:foldl_with_index_prime', [l:incr, a:funexp]))[0]
endfunction
" }}}}

" def foldln {{{{
function! lab42#fn#foldln(list, n, acc, funexp, ...)
  let l:filler = 0
  if a:0 > 0
    let l:filler = a:1
  endif
  let l:count  = a:n
  let l:tail   = a:list
  let l:result = a:acc

  while 1
    let l:head = l:tail[0:a:n - 1]
    let l:tail = l:tail[a:n:]
    if len(l:head) < a:n
      call extend(l:head, repeat([l:filler], a:n - len(l:head)))
    endif
    let l:result = call(a:funexp, [l:result, l:head])
    if empty(l:tail)
      return l:result
    endif
  endwhile
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

" def mapn {{{{
" mapn l n f filler:0 =
"   foldln l n [] (f' f) filler where
"   f' f acc tuple =
"      acc ++ (apply f tuple)
function! s:mapn_prime(funexp, acc, tuple) " --> f'
  return add(a:acc, call(a:funexp, a:tuple))
endfunction
function! lab42#fn#mapn(list, n, funexp, ...)
  let l:filler = 0
  if a:0 > 0
    let l:filler = a:1
  endif
  return lab42#fn#foldln(a:list, a:n, [], function('s:mapn_prime', [a:funexp]), l:filler)
endfunction
" }}}}

" def mapmany {{{{
" mapmany ls f =
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

" def map_with_index {{{{
" map_with_index xs, f, start:0 inc:1 = foldl xs [[], start] (partial f' inc f) |> head where
" f' inc f [l, i] x = [l ++ ( f x i ), i+inc]
function! s:map_with_index_prime(inc, funexp, acc, ele)
  let [l:l, l:i] = a:acc
  let l:next = call(a:funexp, [a:ele, l:i])
  return [add(l:l, l:next), l:i + a:inc]
endfunction
function! lab42#fn#map_with_index(list, funexp, ...)
  let l:start = 0
  let l:inc   = 1
  if a:0 > 1
    let l:inc = a:2
  endif
  if a:0 > 0
    let l:start = a:1
  endif
  return lab42#fn#foldl(a:list, [[], l:start], function('s:map_with_index_prime', [l:inc, a:funexp]))[0]
endfunction
" }}}}

" def map_with_index1 {{{{
" map_with_index xs, f, start:0 inc:1 =
"   foldl_with_index xs [] (partial f' f) where
" f' f acc [x, i] = acc ++ [( f x, i ), i]
function! s:map_with_index1_prime(funexp, acc, val_idx_pair)
  let [_, l:idx] = a:val_idx_pair
  let l:next = call(a:funexp, a:val_idx_pair)
  return add(a:acc, [l:next, l:idx])
endfunction
function! lab42#fn#map_with_index1(list, funexp, ...)
  let l:start = 0
  let l:inc   = 1
  if a:0 > 1
    let l:inc = a:2
  endif
  if a:0 > 0
    let l:start = a:1
  endif
  return lab42#fn#foldl_with_index(a:list, [], function('s:map_with_index1_prime', [a:funexp]), l:start, l:inc)
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
endfunction " }}}}

" def with_index {{{{
" with_index xs start:0 inc:1 = (foldl xs [[], start] (partial f' inc))[0] where
" f' inc [l, i] x = [l ++ x, i+inc]
function! s:with_index_prime(inc, acc, ele)
  let [l:l, l:i] = a:acc
  return [add(l:l, [a:ele, l:i]), l:i + a:inc]
endfunction
function! lab42#fn#with_index(list,...)
  let l:start = 0
  let l:inc   = 1
  if a:0 > 1
    let l:inc = a:2
  endif
  if a:0 > 0
    let l:start = a:1
  endif
  return lab42#fn#foldl(a:list, [[], l:start], function('s:with_index_prime', [l:inc]))[0]
endfunction " }}}}

" def zip *lists {{{{
" zip heads &rest = map_with_index heads (partial zip' rest) where
" zip' others ele idx = [ele (map others (partial ele idx))] where
" ele idx list = list[idx]
function! s:ele(idx, list)
  return a:list[a:idx]
endfunction
function! s:zip_prime(others, ele, idx)
  return insert(lab42#fn#map(a:others, function('s:ele', [a:idx])), a:ele)
endfunction
function! lab42#fn#zip(list, ...)
  let l:rest = copy(a:000)
  return lab42#fn#map_with_index(a:list, function('s:zip_prime', [l:rest]))
endfunction " }}}}

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
"----------------------------------------------------------------------------
"  Function Composition {{{
function! s:compose(funs, ...) " {{{{
  let l:args = call(a:funs[0], copy(a:000))
  for l:Fun in a:funs[1:-1]
    let l:args = call(l:Fun, [l:args])
  endfor
  return l:args
endfunction
function! lab42#fn#compose(...)
  return function('s:compose', [a:000])
endfunction

function! s:concat_fns(funs, ...) " {{{{
  let l:result = []
  for l:Fn in a:funs
    call add(l:result, call(l:Fn, a:000))
  endfor
  return l:result
endfunction
function! lab42#fn#concat_fns(...)
  return function('s:concat_fns', [a:000])
endfunction " }}}}
"  }}}
