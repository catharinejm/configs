set incsearch

if !has("gui_running") && $TERM == "xterm-256color"
  set t_Co=256
  color molokai

  " hi Normal          ctermfg=252 ctermbg=0

  hi StatusLine ctermfg=250 ctermbg=232
  hi StatusLineNC ctermfg=235 ctermbg=255
  hi Pmenu           ctermfg=16  ctermbg=208
  hi Cursor          ctermfg=16  ctermbg=0
  hi Special          ctermbg=233

end

" hi IncSearch guifg=#66418C guibg=#141321
" hi Search guifg=#66418C guibg=#141321
