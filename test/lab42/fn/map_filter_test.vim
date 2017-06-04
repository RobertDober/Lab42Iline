function! s:oddsquares(...)
  let l:n = a:1
  if a:0 > 1
    let l:n = a:2
  endif
  if l:n %2 == 0
    return [0, 0]
  else
    return [1, l:n * l:n]
  endif
endfunction

function! s:double(x)
  return a:x . a:x 
endfunction

function! TestOddSquares()
  let l:values = range(6)
  let l:result = lab42#fn#map_filter(l:values, function('s:oddsquares'))
  call lab42#test#assert_eq([1, 9, 25], l:result)
endfunction
