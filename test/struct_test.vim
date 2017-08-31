function! TestStruct()
  call Struct('Result', 'status', 'value')
  let l:ok = Result('ok', 42)

  let l:error = Result('error', 0)
  call lab42#test#assert_eq('ok', l:ok.status())
  call lab42#test#assert_eq(42, l:ok.value())
  call lab42#test#assert_eq('error', l:error.status())
  call lab42#test#assert_eq(0, l:error.value())
endfunction
