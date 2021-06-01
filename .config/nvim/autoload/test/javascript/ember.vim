function! test#javascript#ember#test_file(file) abort
  if a:file =~# g:test#javascript#ember#file_pattern
      if exists('g:test#javascript#runner')
          return g:test#javascript#runner ==# 'ember'
      else
        return test#javascript#has_package('ember-cli')
      endif
  endif
endfunction

if !exists('g:test#javascript#ember#file_pattern')
  let g:test#javascript#ember#file_pattern = '\vtests?/.*\.(js)$'
endif

if !exists('g:test#javascript#ember#config_module')
  let g:test#javascript#ember#config_module = 'tests'
endif


function! s:nearest_test(position) abort
  let name = test#base#nearest_test(a:position, g:test#javascript#patterns)
  return join(name['test'])
endfunction

function! s:nearest_module(position) abort
  let patterns = {
    \ 'test': [],
    \ 'namespace': [
      \'\v^\s*module.*\s*[(]\s*[^,]+\s*,\s*["|''|`](.*)["|''|`]+',
      \'\v^\s*%(QUnit\.module|module)\s*[(]\s*["|''|`](.*)["|''|`]'
    \],
  \}
  let name = test#base#nearest_test(a:position, l:patterns)
  return join(name['namespace'], ' > ')
endfunction

function! test#javascript#ember#build_position(type, position) abort
  let name = s:nearest_test(a:position)
  let module = s:nearest_module(a:position)
  let args = []

  if a:type ==# 'nearest'
    if !empty(name) && !empty(module)
      let nearest_test_name = join([module, name], ': ')
      call add(args, '--filter='.shellescape(nearest_test_name, 1))
    elseif !empty(module)
      call add(args, '--module='.shellescape(module, 1))
    elseif !empty(name)
      call add(args, '--filter='.shellescape(name, 1))
    endif
  elseif a:type ==# 'file'
    if !empty(module)
      call add(args, '--filter='.shellescape(module, 1))
    endif
  endif

  return args
endfunction

function! test#javascript#ember#executable() abort
  if filereadable('node_modules/.bin/ember')
    return 'ember exam '
  else
    echo 'could not find ember'
    return ''
  endif
endfunction



function! test#javascript#ember#build_args(args) abort
  let args = a:args
  return args
endfunction
