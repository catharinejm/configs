set incsearch

if !has("gui_running") && $TERM == "xterm-256color"
  set t_Co=256
  color torte
end

hi IncSearch guifg=#66418C guibg=#141321
hi Search guifg=#66418C guibg=#141321
