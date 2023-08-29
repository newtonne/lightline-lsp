"------------------------------------------------------------------------------
" Customisation
"------------------------------------------------------------------------------

let s:indicator_infos = get(g:, 'lightline#lsp#indicator_infos', 'I: ')
let s:indicator_warnings = get(g:, 'lightline#lsp#indicator_warnings', 'W: ')
let s:indicator_errors = get(g:, 'lightline#lsp#indicator_errors', 'E: ')
let s:indicator_ok = get(g:, 'lightline#lsp#indicator_ok', 'OK')

"------------------------------------------------------------------------------
" Functions
"------------------------------------------------------------------------------

function! lightline#lsp#infos() abort
  if !lightline#lsp#enabled()
    return ''
  endif
  let l:counts = lsp#lsp#ErrorCount()
  return l:counts.Info == 0 ? '' : printf(s:indicator_infos . '%d', l:counts.Info)
endfunction

function! lightline#lsp#warnings() abort
  if !lightline#lsp#enabled()
    return ''
  endif
  let l:counts = lsp#lsp#ErrorCount()
  return l:counts.Warn == 0 ? '' : printf(s:indicator_warnings . '%d', l:counts.Warn)
endfunction

function! lightline#lsp#errors() abort
  if !lightline#lsp#enabled()
    return ''
  endif
  let l:counts = lsp#lsp#ErrorCount()
  return l:counts.Error == 0 ? '' : printf(s:indicator_errors . '%d', l:counts.Error)
endfunction

function! lightline#lsp#ok() abort
  if !lightline#lsp#enabled()
    return ''
  endif
  let l:counts = lsp#lsp#ErrorCount()
  let l:total = l:counts.Info + l:counts.Warn + l:counts.Error
  return l:total == 0 ? s:indicator_ok : ''
endfunction

" Checks if buffer has an lsp server connected
" There may be a better check we can do here but this seems to work ok
function! lightline#lsp#enabled() abort
  return lsp#buffer#BufHasLspServer(bufnr())
endfunction
