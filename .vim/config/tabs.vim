" ENABLE THE TAB BAR
  set showtabline=1
  
" TAB NAVIGATION
  nmap } :tabnext<cr>
  nmap { :tabprevious<cr>  
  map <D-]> :tabnext<cr>
  map <D-[> :tabprevious<cr>
  imap <D-[> :tabp<cr>i<Right>
  imap <D-]> :tabn<cr>i<Right>

  map <D-1> :tabn 1<cr>
  map <D-2> :tabn 2<cr>
  map <D-3> :tabn 3<cr>
  map <D-4> :tabn 4<cr>
  map <D-5> :tabn 5<cr>
  map <D-6> :tabn 6<cr>
  map <D-7> :tabn 7<cr>
  map <D-8> :tabn 8<cr>
  map <D-9> :tabn 9<cr>
  map <D-0> :tablast<cr>
  imap <D-1> <Esc>:tabn 1<cr>i
  imap <D-2> <Esc>:tabn 2<cr>i
  imap <D-3> <Esc>:tabn 3<cr>i
  imap <D-4> <Esc>:tabn 4<cr>i
  imap <D-5> <Esc>:tabn 5<cr>i
  imap <D-6> <Esc>:tabn 6<cr>i
  imap <D-7> <Esc>:tabn 7<cr>i
  imap <D-8> <Esc>:tabn 8<cr>i
  imap <D-9> <Esc>:tabn 9<cr>i
  imap <D-0> <Esc>:tablast<cr>i
