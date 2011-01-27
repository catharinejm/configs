set tabline=%!MyTabLine()
set gcr=a:blinkon0
hi LineNr guibg=#141414

" pretty but not terminal-compatible color scheme
colors baycomb
hi CursorColumn  guibg=#1A1625
hi CursorLine    guibg=#1A1625
hi Normal        guibg=#000000

set cursorline
set cursorcolumn

set guioptions-=T

if has("mac")
  set transparency=7
  set guifont=Monaco:h14
endif
