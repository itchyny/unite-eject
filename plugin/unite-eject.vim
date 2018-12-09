" =============================================================================
" Filename: plugin/unite-eject.vim
" Author: itchyny
" License: MIT License
" Last Change: 2018/12/09 17:36:22.
" =============================================================================

if exists('g:loaded_unite_eject') || v:version < 703
  finish
endif
let g:loaded_unite_eject = 1

let s:save_cpo = &cpo
set cpo&vim

let s:unite_eject = {
      \ 'description': 'eject',
      \ 'is_selectable': 0,
      \ }

function! s:unite_eject.func(candidate)
  let cmd = executable('eject') ? 'eject' : executable('diskutil') ? 'diskutil umount' : ''
  if cmd ==# ''
    echoerr 'eject or diskutil required'
  else
    call term_start([&shell, &shellcmdflag, 'sudo ' . cmd . ' "' . a:candidate.action__path . '"'])
  endif
endfunction

call unite#custom_action('file', 'eject', s:unite_eject)

let g:unite_eject = s:unite_eject

let &cpo = s:save_cpo
unlet s:save_cpo
