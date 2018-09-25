" Ruby Filters {{{
command! -range -nargs=1 -complete=file RubyF :call lab42#ruby#filter(<line1>,<line2>,<q-args>) 
" }}}
" Struct {{{
" Compiler Helpers {{{{
function! s:make_metod_name(class, method)
  let l:class = substitute(a:class, '^s:', '', '')
  let l:class = substitute(l:class, '.*#', '', '')
  return 's:__' . l:class . '__' . a:method
endfunction

function! s:method_implementation(class, method)
  let l:code = []
  call add(l:code, 'function! ' . s:make_metod_name(a:class, a:method) . '(internal)')
  call add(l:code, '  return a:internal._' . a:method)
  call add(l:code, 'endfunction')
  return join(l:code, "\n")
endfunction
" }}}}

function! s:struct(name, method_names)
  " define constructor TODO: Refactor
  let l:code = []
  call add(l:code, 'function! ' . a:name . '(' . join(a:method_names, ',') . ')')
  call add(l:code, '  let l:wrapper = {}')
  call add(l:code, '  let l:object  = {''__wrapper'': l:wrapper}')

  "   define members
  for l:member_name in a:method_names
    "  ... data
    call add(l:code, '  call extend(l:object, {''_' . l:member_name . ''': a:' . l:member_name . '})') 
    "  ... and accessor
    " call extend(l:wrapper, {l:funname: funcref('s:' . l:funname, [l:object])})
    call add(l:code, "  call extend(l:wrapper, {'" . l:member_name . "': funcref('" . s:make_metod_name(a:name, l:member_name) . "', [l:object])})" )
  endfor

  call add(l:code, '  return l:wrapper')
  call add(l:code, 'endfunction')
  exec join(l:code, "\n")
endfunction
function! Struct(name, ...)
  let l:method_names = copy(a:000)
  " define method implementations TODO: Replace with each
  for l:method_name in l:method_names
    exec s:method_implementation(a:name, l:method_name)
  endfor
  exec s:struct(a:name, l:method_names)
 endfunction
" }}}
"
" Predefined Structs {{{
" call lab42#data#struct('lab42#data#either', 'type', 'value')
" }}}
