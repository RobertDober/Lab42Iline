
" parse_up_to l pushers poppers =
"   foldl l ["", 0] (partial up_to' pushers poppers) where 
"   up_to' pushers poppers [res, count] ele =
"     if count < 0
"        [res, count]
"     elseif ele in pushers
"       [res + ele, count + 1]
"     elseif ele in poppers
"       [ res + ele, count - 1]
"     else
"       [res + ele, count]
"     endif
"
"
" TODO: Conceive a foldlWithExit function
function! s:parse_up_to_prime(pushers, poppers, acc, ele)
  let [l:result, l:count] = a:acc
  " run through case
  if l:count < 0
    return a:acc
  endif

  call lab42#test#dbg_many(a:ele, a:poppers)
  let l:increment = ( index(a:pushers, a:ele) >= 0 ? 1 : 0)
  let l:increment = ( index(a:poppers, a:ele) >= 0 ? -1 : l:increment)
  return [l:result . a:ele, l:count + l:increment]
endfunction
function! s:parse_up_to(charlist, pushers, poppers)
  return lab42#fn#foldl(a:charlist, ['', 0], function('s:parse_up_to_prime', [a:pushers, a:poppers]))
endfunction

  
function! lab42#parse#up_to(string, pushers, ...)
  if type(a:pushers) == type([])
    let l:pushers = a:pushers
  else
    let l:pushers = split(a:pushers, '\zs')
  endif
  if a:0 > 0
    if type(a:1) == type([])
      let l:poppers = a:1
    else
      let l:poppers = split(a:1, '\zs')
    endif
  else
    let l:poppers = []
  endif

  let [l:result, l:count] = s:parse_up_to(split(a:string, '\zs'), l:pushers, l:poppers)
  return [l:count < 0, l:result]
endfunction