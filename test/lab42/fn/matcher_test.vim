function! TestMatch()
  let l:Matcher = lab42#fn#matcher('<hello>')

  let l:source = ['hello World', ' helloW', ' hello']
  let l:target = lab42#fn#filter(l:source, l:Matcher)
  call lab42#test#assert_eq(['hello World', ' hello'], l:target)
endfunction
