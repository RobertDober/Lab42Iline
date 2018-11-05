function! TestListOfApplications() " {{{{{
  let l:applications = []
  call add(l:applications, lab42#app#new('lab42#fn#add', [1, 2]))
  call add(l:applications, lab42#app#new(lab42#fn#even_fn(), [2]))

  let l:result = lab42#app#map(l:applications)
  call lab42#test#assert_eq([3, 1], l:result)
endfunction " }}}}}

" `lab42#app#foldl1` corresponds to Elixir's |> operator
" as it folds the injected value as first argument into 
" a list of applications
function! TestFoldApplication1() " {{{{{
  let l:applications = []
  call add(l:applications, lab42#app#new(lab42#fn#add_fn(), [1]))
  call add(l:applications, lab42#app#new(lab42#fn#mul_fn(2), []))

  call lab42#test#assert_eq(4, lab42#app#foldl1(l:applications, 1))
endfunction " }}}}}
