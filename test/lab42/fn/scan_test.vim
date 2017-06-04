function! s:sum(a, b)
  return a:a + a:b
endfunction

function! s:concat(l, r)
  return a:l . '/' . a:r
endfunction


function! TestScan()
  let l:values = range(5)
  let l:result = lab42#fn#scan(l:values, function('s:sum'), 1)
  call lab42#test#assert_eq([1,2,4,7,11], l:result )
  let l:result = lab42#fn#scan(l:values, function('s:sum'))
  call lab42#test#assert_eq([0,1,3,6,10], l:result )
  let l:result = lab42#fn#scan(l:values, lab42#fn#adder())
  call lab42#test#assert_eq([0,1,3,6,10], l:result )
endfunction

function! TestScanWithConcat()
  let l:values = ['Users', 'robert', '.vim' ] 
  let l:result = lab42#fn#scan(l:values, function('s:concat'), '')
  call lab42#test#assert_eq( ['/Users', '/Users/robert', '/Users/robert/.vim'], l:result )
endfunction
