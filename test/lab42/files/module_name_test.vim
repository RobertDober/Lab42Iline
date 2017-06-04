function! TestCamelCase()
  call lab42#test#assert_eq('VimFilter', lab42#files#filename2modulename('vim_filter'))
endfunction

function! TestSegments()
  call lab42#test#assert_eq('VimFilter.Elixir', lab42#files#filename2modulename('vim_filter/elixir.ex'))
  call lab42#test#assert_eq('VimFilter.Elixir', lab42#files#filename2modulename('vim_filter/elixir.exs'))
endfunction

function! TestSegmentsAndCongig()
  call lab42#test#assert_eq('VimFilter::Ruby', lab42#files#filename2modulename('vim_filter/ruby.rb'))
  
endfunction

