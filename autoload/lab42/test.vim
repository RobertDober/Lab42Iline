" -------------------------------------------------------------------------------------------------------------------------
"  Imports
" -------------------------------------------------------------------------------------------------------------------------
function! s:blue(str)
  return lab42#script#blue(a:str)
endfunction

function! s:green(str)
  return lab42#script#green(string(a:str))
endfunction

function! s:red(str)
  return lab42#script#red(string(a:str))
endfunction

function! s:yellow(str)
  return lab42#script#yellow(a:str)
endfunction


" -------------------------------------------------------------------------------------------------------------------------
"  Output
" -------------------------------------------------------------------------------------------------------------------------
function! s:document(str) " {{{
  if s:doc
    call add(s:messages, a:str)
  endif
endfunction

function! s:reportResults()
  call lab42#putl(s:messages)
  call lab42#puts(s:yellow('--------------------------- Test Results  ---------------------------'))
  for l:msg in s:failures
    call lab42#puts(l:msg)
  endfor
  call lab42#puts("")

  if empty(s:failures)
    call lab42#puts( s:green('All passed ✔') . ' tests: ' . string(s:testcount) . ', assertions: ' . string(s:assertcount))
  else
    call lab42#puts( s:red( 'Failure ✗') . ' tests: ' . string(s:testcount) . ', assertions: ' . string(s:assertcount) . ', failures: ' . s:red(len(s:failures)))
  endif
  call lab42#putl(s:dbgmessages)
endfunction

" available to tested libraries, it will add output to debug_messages
function! lab42#test#dbg(...)
  if s:silent
    return
  endif
  let l:msg = 'DBG AUTO MARKER: ----------------------------------------------------> Debugging'
  if a:0 > 0
    let l:msg = string(a:1)
  endif
  if a:0 < 2
    call add(s:dbgmessages, s:yellow(l:msg))
  else
    call add(s:dbgmessages, call('printf', a:000))
  endif
endfunction

function! lab42#test#dbg_many(...)
  return lab42#fn#map(copy(a:000), function('lab42#test#dbg', []))
endfunction
" }}}

" -------------------------------------------------------------------------------------------------------------------------
"  Assertions {{{
" -------------------------------------------------------------------------------------------------------------------------
function! lab42#test#assert_eq(expected, actual, ...) " {{{{{
  let l:msg = ''
  if a:0 > 0
    let l:msg = s:yellow(" «" . a:1 . "»")
  endif

  call s:increment_assertions()

  let l:etype = type(a:expected)
  let l:atype = type(a:actual)
  if l:etype != l:atype
    call s:addFailure(printf(' expected type: %s, actual type: %s%s', s:green(string(l:etype)), s:red(string(l:atype)), l:msg))
  elseif a:expected != a:actual
    call s:addFailure(printf(' expected: %s, actual: %s%s', s:green(string(a:expected)), s:red(string(a:actual)), l:msg))
  endif
endfunction " }}}}}

function! lab42#test#assert_near(expected, actual, ...) " {{{{{
  let l:msg = ''
  let l:exp_delta = 0.000001
  if a:0 > 0
    let l:exp_delta = a:1
  endif
  if a:0 > 1
    let l:msg = s:yellow(" «" . a:2 . "»")
  endif

  call s:increment_assertions()

  let l:etype = type(a:expected)
  let l:atype = type(a:actual)
  if l:etype != l:atype
    return s:addFailure(printf(' expected type: %s, actual type: %s%s', s:green(string(l:etype)), s:red(string(l:atype)), l:msg))
  endif
  let l:act_delta = abs(a:expected - a:actual)
  if l:act_delta > l:exp_delta
    call s:addFailure(printf(' expected: %s to be close to %s (delta: %s) but delta was %s %s', s:red(a:actual), s:green(a:expected), s:green(l:exp_delta), s:red(l:act_delta), l:msg))
  endif
endfunction " }}}}}
function! lab42#test#buffer_lines(expected, start_line, ...) " {{{{{
  if a:0
    let l:end_line = a:1
  else
    let l:end_line = a:start_line
  endif
  if type(a:expected) == 1
    let l:expected = [a:expected]
  else
    let l:expected = a:expected
  endif
  call lab42#test#assert_eq(l:expected, getline(a:start_line, l:end_line))
endfunction " }}}}}
function! lab42#test#assert_false(expression, ...) " {{{{{
  let l:msg = ''
  if a:0 > 0
    let l:msg = s:yellow(" «" . a:1 . "»")
  endif

  call s:increment_assertions()

  if a:expression
    call s:addFailure(printf(' expected %s to be false, but was not%s', s:red(string(a:expression)), l:msg))
  endif
endfunction " }}}}}
function! lab42#test#assert_throws(funexp, rgx, ...) " {{{{{
  let l:msg = ''
  if a:0 > 0
    let l:msg = s:yellow(" «" . a:1 . "»")
  endif
  call s:increment_assertions()
  try
    call call(a:funexp, [])
  catch /.*/
    if match(v:exception, a:rgx) < 0
      call s:addFailure(printf( ' expected %s to throw %s, but it threw %s%s', s:blue(string(a:funexp)), s:green(a:rgx), s:red(v:exception), l:msg))
      return 0
    else
      return 1
    endif
  endtry
  call s:addFailure(printf( ' expected %s to throw %s, but it did not throw anything%s', s:blue(string(a:funexp)), s:green(a:rgx), l:msg))
endfunction " }}}}}
function! lab42#test#assert_true(expression, ...) " {{{{{
  let l:msg = ''
  if a:0 > 0
    let l:msg = s:yellow(" «" . a:1 . "»")
  endif

  call s:increment_assertions()

  if !a:expression
    call s:addFailure(printf(' expected %s to be true, but was not%s', s:red(string(a:expression)), l:msg))
  endif
endfunction " }}}}}
" }}}
" -------------------------------------------------------------------------------------------------------------------------
"  Counts
" -------------------------------------------------------------------------------------------------------------------------
function! s:increment_assertions()
  let s:assertcount += 1
  let s:localassertcount += 1
endfunction

" -------------------------------------------------------------------------------------------------------------------------
"  Test Management
" -------------------------------------------------------------------------------------------------------------------------
function! s:addFailure(msg)
  let s:errcount += 1
  let l:location = printf(' in %s/%d (%s)', s:blue(s:currtest), s:localassertcount, s:currfile)
  call add(s:failures, s:error . a:msg . l:location)
endfunction

function! s:cleanupTestFunction(_,testfnline)
  return substitute(a:testfnline, '\v^\s*function!?\s+(.*)\(.*', '\1', '')
endfunction

function! s:filterTest(_,testname)
  return a:testname =~ '^' . s:filter . '$'
endfunction

function! s:parseTests()
  let l:testLines = filter(getline(1, '$'), 'v:val =~ "^\s*function! Test"')
  let l:filtered  = map(l:testLines, function('s:cleanupTestFunction'))
  let l:filtered  = filter(l:filtered, function('s:filterTest'))
  return l:filtered
endfunction

function! s:initTests()
  let s:dbgmessages = []
  let s:error       = s:red('✗ err')
  let s:testcount   = 0
  let s:errcount    = 0
  let s:assertcount = 0
  let s:failures    = []
  let s:messages    = []
endfunction

function! s:wrap(test)
  let l:oldcount = s:errcount
  if !empty(s:buffer)
    exec 'edit! ' . s:buffer
  endif
  try
    exec 'call ' . a:test . '()'
  catch /.*/
    call s:document('   ' .  s:blue(s:currtest) . ' ' . s:red('✗'))
    call s:addFailure(s:red(' Exception ') . s:yellow( v:exception) . ' ' . v:throwpoint)
  endtry
  if s:errcount == l:oldcount
    call s:document('   ' .  s:blue(s:currtest) . ' ' . s:green('✔'))
  else
    call s:document('   ' .  s:blue(s:currtest) . ' ' . s:red('✗'))
  end
endfunction

let s:buffer = ''
" Instrumentation {{{{
function! lab42#test#use_buffer(name) " {{{{{
  let s:buffer = a:name
endfunction " }}}}}
" }}}}
function! lab42#test#from_file(file)
  exec 'edit! ' . a:file
  let l:tests = s:parseTests()
  let s:currfile = a:file

  exec "source %"
  call s:document('Executing suite ' . s:blue(s:currfile))
  for l:test in l:tests
    let s:testcount += 1
    let s:localassertcount = 0
    let s:currtest = substitute(l:test, '()\s*".*$', '', '')
    call s:wrap(l:test)
  endfor
endfunction

function! lab42#test#runner(files, stdout, ...)
  let l:debug  = 0
  let s:doc    = 0
  let s:filter = '.*'
  let s:silent = 0
  if a:0 > 0
    let l:debug = a:1
  endif
  if a:0 > 1
    let s:doc = a:2
  endif
  if a:0 > 2
    let s:filter = a:3
  endif
  if a:0 > 3
    let s:silent = a:4
  endif

  call lab42#stdout(a:stdout)

  call s:initTests()
  for l:file in a:files
    call lab42#test#from_file(l:file)
  endfor
  call s:reportResults()
  if !l:debug
    quit!
  else
    tabnew
    call setline("$", "Messages:")
    call map(s:messages, 'append("$", v:val)')
    call setline("$", "Failures:")
    call map(s:failures, 'append("$", v:val)')
  endif
endfunction
