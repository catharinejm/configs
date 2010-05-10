" Map command-i to ESC
imap <D-i> <Esc>
nmap <D-i> <Esc>

" Delete all (up to 999) buffers
nmap <LocalLeader>bd :1,999bd

" Run spec under cursor (requires script/spec)
nmap <LocalLeader>sp :call RunCurrentSpec()<cr>

" Disable F1 because it's a pain in my ass
nmap <F1> <Esc>
imap <F1> <Esc>a

" Toggle word wrapping
nmap <LocalLeader>w :set wrap!<cr>

" Fuzzyfinder
let g:FuzzyFinderOptions = { 'Base':{} }
let g:FuzzyFinderOptions.Base.key_open_tab = '<D-CR>'
let g:FuzzyFinderOptions = { 'Base':{} }
let g:FuzzyFinderOptions.Base.key_open_tab = '<D-CR>'
nmap <LocalLeader>t :FuzzyFinderTextMate<cr>

" ERB tags
imap %% <%=%><Left><Left>
