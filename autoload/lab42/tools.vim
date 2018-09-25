function! lab42#tools#splash(values, nargs, ...) " {{{{{
  let l:defaults = copy(a:000)
  call extend(l:defaults, repeat([0], a:nargs))
  " remove unused defaults
  if !empty(a:values)
    call remove(l:defaults, 0, min([len(a:values), len(l:defaults)]) - 1)
  endif

  let l:values = copy(a:values)
  call extend(l:values, l:defaults)
  return l:values[0:a:nargs-1]
endfunction " }}}}}
