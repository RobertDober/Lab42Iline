function! s:integers(from)
  return stream#cons(a:from, funcref('s:integers', [a:from + 1]))
endfunction

function! TestMap()
  let l:ints = s:integers(0)

  call lab42#test#assert_eq([0, 2, 4], l:ints.map(lab42#fn#mult_fn(2)).take(3))
  call lab42#test#assert_true(stream#empty().map(lab42#fn#true_fn()).is_empty())
endfunction

function! TestFilter()
  let l:ints = s:integers(0)

  call lab42#test#assert_eq([0, 2, 4], l:ints.filter(lab42#fn#even_fn()).take(3))

  let l:empty = stream#empty().filter(lab42#fn#true_fn())
  call lab42#test#assert_true(l:empty.is_empty())
  call lab42#test#assert_true(stream#empty().filter(lab42#fn#true_fn()).is_empty())
endfunction

function! TestReject()
  let l:ints = s:integers(0)

  call lab42#test#assert_eq([0, 2, 4], l:ints.reject(lab42#fn#odd_fn()).take(3))
  call lab42#test#assert_true(stream#empty().reject(lab42#fn#true_fn()).is_empty())
  call lab42#test#assert_true(stream#empty().reject(lab42#fn#false_fn()).is_empty())
endfunction

function! TestCombine()
  let l:ints = s:integers(0)
  let l:double = stream#combine(lab42#fn#adder(), l:ints, l:ints)
  let l:tripple = stream#combine(lab42#fn#adder(), l:ints, l:ints, l:ints)
  
  call lab42#test#assert_eq([2, 4, 6], l:double.drop(1).take(3))
  call lab42#test#assert_eq([6, 9], l:tripple.drop(2).take(2))
endfunction

function! TestCombineFinite()
  let l:ones = stream#finite([1, 1, 1])
  let l:digits = stream#finite(range(10))

  call lab42#test#assert_eq([1, 2, 3], stream#combine(lab42#fn#adder(), l:ones, l:digits).all())

endfunction
