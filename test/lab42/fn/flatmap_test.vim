
let s:lines = [ "line 1", "line 2\nline3", "line4", "\nx"]

function! s:splitter_prime(split_by, str)
  return split(a:str, a:split_by)
endfunction
function! s:splitter(...)
  let l:split_by='\v\s+'
  if a:0 > 0
    let l:split_by = a:1
  endif
  return function('s:splitter_prime', [l:split_by])
endfunction

function! s:identity(item)
  return a:item
endfunction

function! TestEmptyFlatMap()
  call lab42#test#assert_eq([], lab42#fn#flatmap([], s:splitter()))
endfunction

function! TestNoFlattenNeededCase()
  call lab42#test#assert_eq(s:lines, lab42#fn#flatmap(s:lines, function('s:identity')))
endfunction

function! TestFlattensCase()
  let l:expected = ["line 1", "line 2", "line3", "line4", "x"]
  call lab42#test#assert_eq(l:expected, lab42#fn#flatmap(s:lines, s:splitter("\n")))

endfunction
