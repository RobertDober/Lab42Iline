
function! s:callWithSplash(nargs, ...) " {{{{{
  return lab42#tools#splash(a:000, a:nargs)
endfunction " }}}}}

function! s:callWithSplashAndDefaults(nargs, defaults, ...) " {{{{{
  let l:params = [copy(a:000), a:nargs]
  call extend(l:params, a:defaults)
  return call(function("lab42#tools#splash"), l:params)
endfunction " }}}}}

function! TestSplashWithDefaultDefaultValues() " {{{{{
  call lab42#test#assert_eq([1, 2, 3], s:callWithSplash(3, 1, 2, 3, 4))
  call lab42#test#assert_eq([1, 2, 3], s:callWithSplash(3, 1, 2, 3))
  call lab42#test#assert_eq([1, 2, 0], s:callWithSplash(3, 1, 2))
  call lab42#test#assert_eq([0, 0, 0], s:callWithSplash(3))
endfunction " }}}}}

function! TestSplashWithCustomDefaults() " {{{{{
  call lab42#test#assert_eq([1, 2, 3], s:callWithSplashAndDefaults(3, ['alpha', 'beta'], 1, 2, 3, 4))
  call lab42#test#assert_eq([1, 2, 3], s:callWithSplashAndDefaults(3, ['alpha', 'beta'], 1, 2, 3))
  call lab42#test#assert_eq([1, 2, 'gamma'], s:callWithSplashAndDefaults(3, ['alpha', 'beta', 'gamma'], 1, 2))
  call lab42#test#assert_eq(['hello', 'beta', 'gamma'], s:callWithSplashAndDefaults(3, ['alpha', 'beta', 'gamma'], 'hello'))
  call lab42#test#assert_eq(['alpha', 'beta', 'gamma'], s:callWithSplashAndDefaults(3, ['alpha', 'beta', 'gamma']))
  
endfunction " }}}}}
