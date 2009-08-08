
  
" Use the cool tab complete menu
  set wildmenu 
  set wildmode=list:longest,full

" TAB COMPLETION FOR AUTO COMPLETE
  if has("eval")
      function! CleverTab()
          if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
              return "\<Tab>"
          else
              return "\<C-N>"
          endif
      endfun
      inoremap <Tab> <C-R>=CleverTab()<CR>
      inoremap <S-Tab> <C-P>
  endif
