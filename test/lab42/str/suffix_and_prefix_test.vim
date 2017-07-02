function! TestGetSuffixHello()
  call lab42#test#assert_eq('', lab42#str#get_suffix('hello', '\s*'))
  call lab42#test#assert_eq('', lab42#str#get_suffix('hello'))
  call lab42#test#assert_eq('   ', lab42#str#get_suffix('hello   '))
  call lab42#test#assert_eq('hello', lab42#str#get_suffix('hello', '.*'))
  call lab42#test#assert_eq('o', lab42#str#get_suffix(' hello', '\v[eo]*'))
endfunction

function! TestGetSuffixWS()
  call lab42#test#assert_eq(' ', lab42#str#get_suffix('hello ', '\s*'))
  call lab42#test#assert_eq(' ', lab42#str#get_suffix('hello ', '\s'))
  call lab42#test#assert_eq(' ', lab42#str#get_suffix('hello ', ' '))
  call lab42#test#assert_eq('  ', lab42#str#get_suffix('hello  ', '\s*'))
  call lab42#test#assert_eq(' ', lab42#str#get_suffix('hello  ', '\s'))
  call lab42#test#assert_eq(' ', lab42#str#get_suffix(' hello  ', ' '))
endfunction


function! TestGetPrefixHello()
  call lab42#test#assert_eq('', lab42#str#get_prefix('hello', '\s*'))
  call lab42#test#assert_eq('', lab42#str#get_prefix('hello'))
  call lab42#test#assert_eq('  ', lab42#str#get_prefix('  hello'))
  call lab42#test#assert_eq('hello', lab42#str#get_prefix('hello', '.*'))
  call lab42#test#assert_eq('', lab42#str#get_prefix('hello', '[eo]*'))
  call lab42#test#assert_eq('h', lab42#str#get_prefix('hello', '.'))
endfunction

function! TestGetPrefixWS()
  call lab42#test#assert_eq(' ', lab42#str#get_prefix(' hello ', '\s*'))
  call lab42#test#assert_eq(' ', lab42#str#get_prefix(' hello ', '\s'))
  call lab42#test#assert_eq(' ', lab42#str#get_prefix(' hello ', ' '))
  call lab42#test#assert_eq('  ', lab42#str#get_prefix('  hello  ', '\s*'))
  call lab42#test#assert_eq(' ', lab42#str#get_prefix('  hello  ', '\s'))
  call lab42#test#assert_eq(' ', lab42#str#get_prefix('  hello  ', ' '))
endfunction

function! TestRemovePrefix()
  call lab42#test#assert_eq('', lab42#str#ltrim(''))
  call lab42#test#assert_eq('hello', lab42#str#ltrim('hello'))
  call lab42#test#assert_eq('ello', lab42#str#ltrim('hello', '.'))
  call lab42#test#assert_eq('hello', lab42#str#ltrim('  hello'))
  call lab42#test#assert_eq('', lab42#str#ltrim('  hello', '.*'))
endfunction

function! TestRemoveSuffix()
  call lab42#test#assert_eq('', lab42#str#rtrim(''))
  call lab42#test#assert_eq('hello', lab42#str#rtrim('hello'))
  call lab42#test#assert_eq(' hello', lab42#str#rtrim(' hellox', '.'))
  call lab42#test#assert_eq('hello', lab42#str#rtrim('hello  '))
  call lab42#test#assert_eq('', lab42#str#rtrim('  hello', '.*'))
endfunction

function! TestSplitWithSuffix()
  " To test the tester
  " call lab42#test#assert_eq(['hello', ''], lab42#str#split_with_suffix(s:yeltp(), '\s*'))
  call lab42#test#assert_eq(['hello', ''], lab42#str#split_with_suffix('hello', '\s*'))
  call lab42#test#assert_eq(['hello', ''], lab42#str#split_with_suffix('hello'))
  call lab42#test#assert_eq(['hello', '   '], lab42#str#split_with_suffix('hello   '))
  call lab42#test#assert_eq(['', 'hello'], lab42#str#split_with_suffix('hello', '.*'))
  call lab42#test#assert_eq([' hell', 'o'], lab42#str#split_with_suffix(' hello', '\v[eo]*'))
endfunction

function! TestSplitWithPrefix()
  call lab42#test#assert_eq(['', 'hello'], lab42#str#split_with_prefix('hello', '\s*'))
  call lab42#test#assert_eq(['', 'hello'], lab42#str#split_with_prefix('hello'))
  call lab42#test#assert_eq(['  ', 'hello'], lab42#str#split_with_prefix('  hello'))
  call lab42#test#assert_eq(['hello', ''], lab42#str#split_with_prefix('hello', '.*'))
  call lab42#test#assert_eq(['he', 'llo'], lab42#str#split_with_prefix('hello', '\v[heo]*'))
  " To test the tester
  " call lab42#test#assert_eq(['*', 'ello'], lab42#str#split_with_prefix('hello', '.'), "oh noooey")
  call lab42#test#assert_eq(['h', 'ello'], lab42#str#split_with_prefix('hello', '.'))
endfunction

function! TestTrim()
  call lab42#test#assert_eq('', lab42#str#trim(''))
  call lab42#test#assert_eq('', lab42#str#trim(' '))
  call lab42#test#assert_eq('alpha', lab42#str#trim(' alpha'))
  call lab42#test#assert_eq('alpha', lab42#str#trim(' alpha  '))
  call lab42#test#assert_eq('', lab42#str#trim('', '[a-e]*'))
  call lab42#test#assert_eq('lp', lab42#str#trim('alpha', '[a-i]*'))
endfunction
