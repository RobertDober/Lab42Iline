function! s:double(a)
  return a:a . a:a
endfunction
let s:Double = function('s:double')

function! s:concat(a, b)
  return a:a . a:b
endfunction
let s:Concat = function('s:concat')
function! s:concat_with(prefix)
  return function('s:concat', [a:prefix])
endfunction


function! TestSimleMap()
  let l:list     = ['the', 'quick', 'brown']

  let l:result   = lab42#fn#map(l:list, s:Double)
  let l:expected = ['thethe', 'quickquick', 'brownbrown']
  call lab42#test#assert_eq(l:expected, l:result)

  let l:expected = ['prefixthe', 'prefixquick', 'prefixbrown']
  let l:result   = lab42#fn#map(l:list, lab42#fn#partial(s:Concat, 'prefix'))
  call lab42#test#assert_eq(l:expected, l:result)

  let l:expected = ['thepostfix', 'quickpostfix', 'brownpostfix']
  let l:result   = lab42#fn#map(l:list, lab42#fn#partial_1(s:Concat, 'postfix'))
  call lab42#test#assert_eq(l:expected, l:result)
endfunction
