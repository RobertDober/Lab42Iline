let s:digits = stream#finite(range(10))
function! s:integers(from)
  return stream#cons(a:from, funcref('s:integers', [a:from + 1]))
endfunction

function! TestZipWithEmpty()
  call lab42#test#assert_true(stream#zip_streams(s:integers(1), s:digits, stream#empty()).is_empty())
endfunction

function! TestZipInfiniteAndFiniteIsFinite()
  let l:zipped = stream#zip_streams(s:integers(0).drop(1), s:digits)
  call lab42#test#assert_eq([[1,0], [2,1]], l:zipped.take(2) )
  " finite!
  " call l:zipped.all()


endfunction
