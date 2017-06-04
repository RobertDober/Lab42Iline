" function! s:join(...)
"   return join(a:000,'/')
" endfunction

function! s:handlebarAlt(fn)
  let l:m = matchlist(a:fn, '\v/app/templates/components/(.*-.*)\.hbs$')
  if !empty(l:m)
    let l:base = l:m[1]
    return substitute(a:fn, l:m[0].'$', '/app/components/' . l:base . '.js', '')
  endif
  let l:m = matchlist(a:fn, '\v/app/components/(.*-.*)\.js$')
  if !empty(l:m)
    let l:base = l:m[1]
    return substitute(a:fn, l:m[0].'$', '/app/templates/components/' . l:base . '.hbs', '')
  endif
  return ''
endfunction

function! s:testAlt(fn)
  let l:m = matchlist(a:fn, '\v/tests/factories/(.*)s\.js$')
  if !empty(l:m)
    return substitute(a:fn, '/tests/factories/.*', '/app/models/' . l:m[1] . '.js', '')
  endif
  return ''
endfunction

function! lab42#files#alt_name(fn)
  let l:result = s:handlebarAlt(a:fn)
  " call writefile([l:result], '/tmp/xxx')
  if !empty(l:result)
    " call writefile(['returned'], '/tmp/xxx', 'a')
    return l:result
  endif
  let l:result = s:testAlt(a:fn)
  if !empty(l:result)
    return l:result
  endif
  return ''
endfunction

" function! lab42#files#find(inDir,name,...)
"   let l:current   = a:inDir
"   if a:0 > 0
"     let l:stopdir = a:1
"   else
"     let l:stopdir = '/'
"   endif
"   while 1
"     let l:candidate = s:join(l:current, a:name)
"     if glob(l:candidate)  == l:candidate
"       return l:candidate
"     elseif l:current == l:stopdir
"       return 0
"     else
"       let l:current = fnamemodify(l:current, ':h')
"     endif
"   endwhile
" endfunction

function! s:extract_filename(line)
  let l:m = matchlist(a:line, '\v\[(.*)\]')
  if empty(l:m)
  "/home/robert/facilecomm/facilecomm_v2_connectors/app/models/concerns/transformable.rb @ line 19 
    let l:m = matchlist(a:line, '\v^\s*(\w+)\s+\@\s+line\s+(\d+)')
    if empty(l:m)
      return a:line
    else
      return l:m[1] . ':' . l:m[2]
    endif
  else
    return l:m[1]
  endif
endfunction

function! lab42#files#open_at_line(...)
  let l:fn = @*
  if a:0 > 0
    let l:fnprime = a:1
    if !empty(l:fnprime)
      let l:fn = l:fnprime
    endif
  endif
  let l:fn = s:extract_filename(l:fn)
  let l:parts = split(l:fn, ":")
  exe 'tabnew ' . l:parts[0]
  if len(l:parts) > 1
    let l:lnb = l:parts[1]
    exe 'normal ' . l:lnb . 'Gzz'
  endif
endfunction

function! s:capitalize(word)
  return toupper(a:word[0]) . tolower(a:word[1:])
endfunction

function! s:camelCase(fname)
  let l:segments = split(a:fname, '_')
  return join(map(l:segments, 's:capitalize(v:val)'), '')
endfunction

let s:filetypeJoiners = { "rb": "::"}

function! lab42#files#filename2modulename(fname)
  let l:basename = fnamemodify(a:fname, ':r')
  let l:extname  = fnamemodify(a:fname, ':e')
  let l:segments = split(l:basename, '/')
  let l:joiner   = get(s:filetypeJoiners, l:extname, '.')
  return join(map(l:segments, 's:camelCase(v:val)'), l:joiner)
endfunction

function! lab42#files#project_path(...)
  if a:0 > 0
    return g:loaded_lab42 . '/' . join(a:000, '/')
  else
    return g:loaded_lab42
  endif
endfunction

function! lab42#files#join(lhp, rhp)
  return a:lhp . '/' . a:rhp
endfunction

function! lab42#files#test_append_to_path(file, path)
  let l:joined = lab42#files#join(a:path, a:file)
  return lab42#files#test_readable(l:joined)
endfunction

function! lab42#files#test_readable(file)
  if file_readable(a:file)
    return [1, a:file]
  else
    return [0, 0]
  end
endfunction
