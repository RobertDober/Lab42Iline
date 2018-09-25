" -----------------------------------------------------------------------
"  Init {{{
function! lab42#buffer_init()
  call lab42#customTypes()
  call s:localFtInit()
endfunction
"  }}}
" -----------------------------------------------------------------------
" Custom FileTypes {{{
" ----------------------------------------------------------
function! s:customTypeWithFt(ft)
  try
    let l:FtFunction = function( 's:customTypeFt__' . a:ft )
  catch /E700/
    let l:FtFunction = function( 's:nop' )
  endtry
  return call(l:FtFunction, [])
endfunction

function! s:customTypeFt__vim()
  let l:al_idx = index(b:path_segments, "autoload")
  if l:al_idx >= 0
    let b:custom_prefix = substitute(join(b:path_segments[l:al_idx+1:], '#') , '\v\.' . b:file_type . '$', '#', '')
    let b:custom_ft = ['vim', 'autoload']
  elseif index(b:path_segments, "test") >=0 && match(b:base_name, '_test\.vim$') > 0
    let b:custom_ft = ['vim', 'test']
    let b:custom_prefix = 'Test'
  endif
  if exists('b:custom_prefix')
    let @p = b:custom_prefix
  endif
endfunction

function! s:nop()
  return 1
endfunction

function! lab42#customTypes()
  let b:file_type     = &ft
  let b:full_path     = expand("%:p")
  let b:path_segments = split(b:full_path, '/')
  if empty(b:path_segments)
    let b:base_name     = "*annon*"
  else
    let b:base_name     = b:path_segments[-1]
  endif
  call s:customTypeWithFt(&ft)
endfunction

function! s:test_append(dir)
  let l:file = lab42#files#join(a:dir, '.vimrc.local.' . b:file_type)
  if file_readable(l:file)
    return [1, l:file]
  else
    return [0, 0]
  endif
endfunction
function! s:localFtInit()
  let l:dir_segments = lab42#fn#scan(b:path_segments, function('lab42#files#join'), '')
  let l:init_files = lab42#fn#map_filter(l:dir_segments, function('s:test_append'))
  for l:init_file in l:init_files
    exe 'source ' . l:init_file
  endfor
endfunction
" }}}

" -----------------------------------------------------------------------
" General Purpose Helpers {{{
let g:lab42_debug = []
function! lab42#dbg(...)
  let g:lab42_debug += a:000
endfunction

function! lab42#dbgl(...)
  let g:lab42_debug += [join(a:000, ",")]
endfunction

function! lab42#dump_dbg()
  for l:line in g:lab42_debug
    call append('$', l:line)
  endfor
  let g:lab42_debug = []
endfunction " }}}

" -----------------------------------------------------------------------
"  Project Types (deprecated) {{{
"

" function! s:setElixirProjectType()
"   let g:lab42_project_type = "elixir-generic"
" endfunction

" function! s:setGenericProjectType()
"   let g:lab42_project_type = "generic-generic"
" endfunction

" function! s:setRubyProjectType()
"   if file_readable("spec_helper.rb")
"     let g:lab42_project_type = "ruby-rspec"
"   elseif file_readable("../test/helper.rb")
"     let g:lab42_project_type = "ruby-minitest"
"   elseif s:base == "lib"
"     let g:lab42_project_type = "ruby-lib"
"   else
"     let g:lab42_project_type = "ruby-unknown"
"   endif
" endfunction

" function! lab42#setProjectType()
"   " Protect agains overwrite. Hmm Do we really want this?
"   if exists("g:lab42_project_type")
"     return
"   endif
"   let s:home = split(expand("$PWD", "/"))
"   let s:base = s:home[-1]

"   " let us check on filetype
"   if file_readable("Gemfile")
"     let g:lab42_project_type = "ruby-generic"
"   elseif file_readable("../Gemfile")
"     call s:setRubyProjectType()
"   elseif file_readable("mix.exs")
"     call s:setElixirProjectType()
"   else
"     call s:setGenericProjectType()
"   endif
" endfunction

" " Moved into cicomplete
" function! lab42#to_expect_syn()
"   call lab42#replace_should()
"   call lab42#replace_should_not()
"   call lab42#replace_eq()
" endfunction
" function! lab42#replace_should()
"   let l:line = getline('.')
"   let l:part1 = substitute(l:line, '\v^(\s*)(.*)\.should>', '\1expect(\2).to', '')
"   call setline('.', l:part1)
" endfunction

" function! lab42#replace_should_not()
"   let l:line = getline('.')
"   let l:part1 = substitute(l:line, '\v^(\s*)(.*)\.should_not>', '\1expect(\2).not_to', '')
"   call setline('.', l:part1)
" endfunction

" function! lab42#replace_eq()
"   let l:line = getline('.')
"   let l:part1 = substitute(l:line, '\v\=\= (.*)', 'eq(\1)', '')
"   call setline('.', l:part1)
" endfunction " }}}

" -----------------------------------------------------------------------
"  VimScript support {{{
" -----------------------------------------------------------------------
function! lab42#stdout(...)
  if a:0
    let s:stdout=a:1
  endif
  return s:stdout
endfunction

function! lab42#puts(...)
  call writefile(a:000, s:stdout, 'a')
endfunction

function! lab42#putl(...)
  for l:list in a:000
    call writefile(l:list, s:stdout, 'a')
  endfor
endfunction " }}}
" -----------------------------------------------------------------------
"  File System support {{{
function! lab42#existsdir(dirname)
  let l:exists = system('test -d ' . expand(a:dirname) . ' && echo YES')
  if l:exists == 'YES'
    return 1
  else
    return 0
  endif
endfunction

function! lab42#mkdir(dirname)
  call system('mkdir -p ' . expand(a:dirname))
endfunction

function! lab42#mkdirif(dirname)
  if ! lab42#existsdir(a:dirname)
    call lab42#mkdir(a:dirname)
  endif
endfunction
"  }}}
