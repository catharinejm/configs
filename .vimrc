  scriptencoding utf-8

" MAKE ARROW KEYS WORK IN CONSOLE VI
  set term=xterm
  
" Set temporary directory (don't litter local dir with swp/tmp files)
  set directory=/tmp/

" Color themes
  "colors spicycode

" This is how Adam likes it
  colors twilight2
  imap <D-i> <Esc>
  nmap <D-i> <Esc>

" These two enable syntax highlighting
  set nocompatible
  syntax on
  
" have one hundred lines of command-line (etc) history:
  set history=100

" Show us the command we're typing
  set showcmd

" Highlight matching parens
  set showmatch

  set completeopt=menu,preview
  
" Use the cool tab complete menu
  set wildmenu 
  set wildmode=list:longest,full

" have the mouse enabled all the time:
  set mouse=a

" * Text Formatting -- General

" don't make it look like there are line breaks where there aren't:
  set nowrap

" use indents of 2 spaces, and have them copied down lines:
  set expandtab
  set tabstop=2
  set softtabstop=2 
  set shiftwidth=2

  set autoindent
  set smartindent
  
""Set to auto read when a file is changed from the outside
  set autoread

" * Search & Replace
" show the `best match so far' as search strings are typed:
  set incsearch
 
" assume the /g flag on :s substitutions to replace all matches in a line:
  set gdefault

" enable line numbers
  set number

" If possible, try to use a narrow line number column.
  if v:version >= 700
      try
        setlocal numberwidth=3
      catch
      endtry
  endif

" FILE BROWSING
" Settings for explorer.vim
  let g:explHideFiles='^\.'

" Settings fo rnetrw
  let g:netrw_list_hide='^\.,\~$'


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

" ENABLE THE TAB BAR
  set showtabline=2 " 2=always

" MAKE BACKSPACE WORK IN INSERT MODE
  set backspace=indent,eol,start

" REMEMBER LAST POSITION IN FILE
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
  
" TAB NAVIGATION
  :nmap } :tabnext<cr>
  :nmap { :tabprevious<cr>  
  :map <D-]> :tabnext<cr>
  :map <D-[> :tabprevious<cr>
  :imap <D-[> :tabp<cr>i<Right>
  :imap <D-]> :tabn<cr>i<Right>

  :map <D-1> :tabn 1<cr>
  :map <D-2> :tabn 2<cr>
  :map <D-3> :tabn 3<cr>
  :map <D-4> :tabn 4<cr>
  :map <D-5> :tabn 5<cr>
  :map <D-6> :tabn 6<cr>
  :map <D-7> :tabn 7<cr>
  :map <D-8> :tabn 8<cr>
  :map <D-9> :tabn 9<cr>
  :map <D-0> :tablast<cr>
  :imap <D-1> <Esc>:tabn 1<cr>i
  :imap <D-2> <Esc>:tabn 2<cr>i
  :imap <D-3> <Esc>:tabn 3<cr>i
  :imap <D-4> <Esc>:tabn 4<cr>i
  :imap <D-5> <Esc>:tabn 5<cr>i
  :imap <D-6> <Esc>:tabn 6<cr>i
  :imap <D-7> <Esc>:tabn 7<cr>i
  :imap <D-8> <Esc>:tabn 8<cr>i
  :imap <D-9> <Esc>:tabn 9<cr>i
  :imap <D-0> <Esc>:tablast<cr>i
  
  imap %% <%=%><Left><Left>

  ""Nice statusbar
  set laststatus=2
  set statusline=\ "
  set statusline+=%f\ " file name
  set statusline+=[
  set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
  set statusline+=%{&fileformat}] " file format

  set statusline+=%h%1*%m%r%w%0* " flag
  set statusline+=%= " right align
  set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

  " title: update the title of the window?
  set   title

  " titlestring: what will actually be displayed
  set   titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70
  " Turn off rails bits of statusbar
  let g:rails_statusline=0

  autocmd BufRead,BufNewFile *.rsel    set filetype=ruby

" Delete all (up to 999) buffers
  nmap :bda :1,999bd
