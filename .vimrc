" https://devel.tech/snippets/n/vIIMz8vZ/load-vim-source-files-only-if-they-exist
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

" Restore defaults if available.
unlet! skip_defaults_vim
call SourceIfExists("$VIMRUNTIME/defaults.vim")

set number
