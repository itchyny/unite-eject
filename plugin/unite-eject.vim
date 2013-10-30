" =============================================================================
" Filename: plugin/unite-eject.vim
" Author: itchyny
" License: MIT License
" Last Change: 2013/10/31 01:09:49.
" =============================================================================

if exists('g:loaded_unite_eject')
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

let s:unite_eject = {
      \ 'description': 'eject',
      \ 'is_selectable': 0,
      \ }

function! s:unite_eject.func(candidate)
  try
    let cmd = executable('eject') ? 'eject' : executable('diskutil') ? 'diskutil umount' : ''
    if strlen(cmd)
      let c = 'sudo ' . cmd . ' "' . a:candidate.action__path . '"'
      exe 'VimShellInteractive --split="15split" ' . c
    endif
  catch
  endtry
endfunction

if exists('*unite#custom_action')
  call unite#custom_action('file', 'eject', s:unite_eject)
endif

let g:unite_eject = s:unite_eject

let g:loaded_unite_eject = 1

let &cpo = s:save_cpo
unlet s:save_cpo
