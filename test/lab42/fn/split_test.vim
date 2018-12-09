let s:list = []
let s:list += ['line 1','', 'line 2', '  ', 'line 3', 'line 4', '', 'line 5']

function! TestSplitAlone() " {{{{{
  let l:result = lab42#list#split(s:list, lab42#fn#matcher('^\s*$'), 2)
  let l:expected = []
  let l:expected += [['line 1'], [''], ['line 2'], ['  '], ['line 3', 'line 4'], [''], ['line 5']]
  call lab42#test#assert_eq(l:expected, l:result)
endfunction " }}}}}
function! TestSplitExclude() " {{{{{
  let l:result = lab42#list#split(s:list, lab42#fn#matcher('^\s*$'))
  let l:expected = []
  let l:expected += [['line 1'], ['line 2'], ['line 3', 'line 4'], ['line 5']]
  call lab42#test#assert_eq(l:expected, l:result)
endfunction " }}}}}

function! TestSplitPart() " {{{{{
  let l:result = lab42#list#split(s:list, lab42#fn#matcher('^\s*$'), 1)
  let l:expected = []
  let l:expected += [['line 1'], ['', 'line 2'], ['  ', 'line 3', 'line 4'], ['', 'line 5']]
  call lab42#test#assert_eq(l:expected, l:result)
endfunction " }}}}}
