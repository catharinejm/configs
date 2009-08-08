" Map command-i to ESC
  imap <D-i> <Esc>
  nmap <D-i> <Esc>

" ERB tags!
  imap %% <%=%><Left><Left>

" Delete all (up to 999) buffers
  nmap :bda :1,999bd
