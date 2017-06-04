
" ------------------------------------------------------------------
"  Helpers
" ------------------------------------------------------------------
function! s:alt(name)
  return lab42#files#alt_name(a:name)
endfunction

" ------------------------------------------------------------------
"  Tests
" ------------------------------------------------------------------
function! TestAltFileNotDefined()
  call lab42#test#assert_eq( '', s:alt('/home/robert/something'))
endfunction

function! TestHandlebarComponents()
  call lab42#test#assert_eq('/something/app/components/my-file.js',
        \ s:alt('/something/app/templates/components/my-file.hbs'))
endfunction

function! TestJSComponents()
  call lab42#test#assert_eq('/something/app/templates/components/my-file.hbs',
        \ s:alt('/something/app/components/my-file.js'))
  
endfunction
