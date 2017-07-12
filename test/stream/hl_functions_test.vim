function! s:integers(from)
  return stream#cons(a:from, funcref('s:integers', [a:from + 1]))
endfunction

function! TestMap()
  let l:ints = s:integers(0)

  call lab42#test#assert_eq([0, 2, 4], l:ints.map(lab42#fn#mult_fn(2)).take(3))

endfunction
