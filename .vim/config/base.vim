" New in 7.3
if version >= 703
  set undodir=~/.vim_undo/
  set undofile

"   au BufNewFile,BufRead * set relativenumber
end

" These two enable syntax highlighting
  set nocompatible
  syntax on

" Enable highlighting of ruby operators
  let g:ruby_operators = 1

filetype plugin indent on

set scrolloff=6

set mouse=a
scriptencoding utf-8
set term=xterm
set directory=/tmp/
set history=100
set showcmd
set showmatch
set completeopt=menu,preview
set backspace=indent,eol,start
set nowrap

set expandtab
set tabstop=2
set softtabstop=2 
set shiftwidth=2
set autoindent
  
set autoread

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


" REMEMBER LAST POSITION IN FILE
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
  

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

set cursorcolumn
set cursorline
