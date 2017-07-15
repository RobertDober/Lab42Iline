let s:digits = stream#finite(range(10))
function! s:integers(from)
  return stream#cons(a:from, funcref('s:integers', [a:from + 1]))
endfunction

function! TestFiniteScan()
  call lab42#test#assert_eq([0,1,3,6,10,15,21,28,36,45], s:digits.scan(0, lab42#fn#adder()).all())
endfunction

function! TestEmptyScan()
  call lab42#test#assert_true(stream#empty().scan(1, lab42#fn#adder()).is_empty())
endfunction

function! TestEmptyScanWith()
  call lab42#test#assert_true(stream#empty().scan_with(1, lab42#fn#adder()).is_empty())
endfunction

function! TestInfiniteScan()
  let l:ints = s:integers(1)

  let l:expected = [2, 2, 3]
  call lab42#test#assert_eq(l:expected, l:ints.scan(0, lab42#fn#rev_sub_fn()).drop(2).take(3))
endfunction

function! TestFiniteScanWith()
  let l:expected = [[10, 0], [9, 1], [7, 2], [4, 3]]
  call lab42#test#assert_eq(l:expected, s:digits.scan_with(10, lab42#fn#sub_fn()).take(4))
endfunction

function! TestInFiniteScanWith()
  let l:expected = [[10, 0], [9, 1], [7, 2], [4, 3]]
  call lab42#test#assert_eq(l:expected, s:integers(0).scan_with(10, lab42#fn#sub_fn()).take(4))
endfunction

