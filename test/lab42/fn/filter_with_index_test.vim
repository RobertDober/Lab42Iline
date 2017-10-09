
function! s:match(pattern, rgx)
  let [l:pattern, _] = a:pattern
  return match(l:pattern, '\v' . a:rgx) >= 0
endfunction

function! s:matches(rgx)
  return lab42#fn#partial_1(function('s:match'), a:rgx)
endfunction

function! TestSimpleFilterWithIndex()
  let l:list     = ['the', 'quick', 'brown']

  let l:result   = lab42#fn#filter_with_index(l:list, s:matches('i'))
  let l:expected = [['quick', 1]]
  call lab42#test#assert_eq(l:expected, l:result)

  let l:result   = lab42#fn#filter_with_index(l:list, s:matches('i'), 1)
  let l:expected = [['quick', 2]]
  call lab42#test#assert_eq(l:expected, l:result)

  let l:result   = lab42#fn#filter_with_index(l:list, s:matches('i'), 1, 2)
  let l:expected = [['quick', 3]]
  call lab42#test#assert_eq(l:expected, l:result)
endfunction

function! s:car_empty(cons)
  let [l:car, _] = a:cons
  return lab42#fn#empty(l:car)
endfunction

function! TestSimpleRejectWithIndex()
  let l:list     = ['the', '', 'quick', '', 'brown']
  let l:expected = [['the', 0], ['quick', 4], ['brown', 8]]

  let l:result   = lab42#fn#reject_with_index(l:list, function('s:car_empty'), 0, 2)
  call lab42#test#assert_eq(l:expected, l:result)
endfunction
