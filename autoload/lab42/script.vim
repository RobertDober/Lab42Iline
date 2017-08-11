" -------------------------------------------------------
"  Colorisation
" -------------------------------------------------------
function! lab42#script#with_color(colorcode, msg)
  if type(a:msg) == type('')
    return printf('[' . a:colorcode . 'm%s[0m', a:msg)
  else
    return printf('[' . a:colorcode . 'm%s[0m', string(a:msg))
  endif
endfunction

function! lab42#script#red(msg)
  return lab42#script#with_color(31, a:msg)
endfunction
function! lab42#script#green(msg)
  return lab42#script#with_color(32, a:msg)
endfunction
function! lab42#script#blue(msg)
  return lab42#script#with_color(34, a:msg)
endfunction
function! lab42#script#yellow(msg)
  return lab42#script#with_color(33, a:msg)
endfunction
function! lab42#script#run(scriptfile, stdout)
  try
    call lab42#stdout(a:stdout)
    exec 'source ' . a:scriptfile
    call Main()
  catch /.*/
    " Puts lab42#script#red(v:exception)
    lab42#puts lab42#script#red(v:exception)
  endtry
endfunction
