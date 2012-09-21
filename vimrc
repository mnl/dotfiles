
"""""""""""""""""""""""""""""""""
" Mickes VIMRC                  "
" Sun Sep 25 23:40:32 CEST 2011 "
"""""""""""""""""""""""""""""""""

" Don't save backups of *.gpg files
set backupskip+=*.gpg
" To avoid that parts of the file is saved to .viminfo when yanking or
" deleting, empty the 'viminfo' option.
set viminfo=

" colors
 colorscheme wombat256
 set t_Co=256 "my terminals are always colored

" GUI specific options
" This replaces .gvimrc
if has('gui_running')
  colorscheme dusk
  set lines=50 columns=100
  set guifont=Monospace
endif

" Make clipboard work as expected
set clipboard=autoselect,unnamed,exclude:cons\|linux

" misc
syntax on
filetype on
set visualbell
set ruler
set hlsearch

" indenting
 set tabstop=4
 set smartindent
 set autoindent
 set smarttab

" backups and swapfiles
set backup
silent !mkdir -p ~/.vim/backup
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

" shortcuts
cnoreabbrev W w
cnoreabbrev Q q


" Only do this part when compiled with support for autocommands.
if has("autocmd")
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

" Set File type to 'text' for files ending in .txt
  autocmd BufNewFile,BufRead *.txt setfiletype text

" Enable soft-wrapping for text files
  autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

" Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

" For all text files set 'textwidth' to 78 characters.
" autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" |
    \ endif

" Automatically load .vimrc source when saved
  autocmd BufWritePost .vimrc source $MYVIMRC

  augroup END

  augroup encrypted
    au!
    " Disable swap files, and set binary file format before reading the file
    autocmd BufReadPre,FileReadPre *.gpg
      \ setlocal noswapfile bin
    " Decrypt the contents after reading the file, reset binary file format
    " and run any BufReadPost autocmds matching the file name without the .gpg
    " extension
    autocmd BufReadPost,FileReadPost *.gpg
      \ execute "'[,']!gpg --decrypt --default-recipient-self" |
      \ setlocal nobin |
      \ execute "doautocmd BufReadPost " . expand("%:r")
    " Set binary file format and encrypt the contents before writing the file
    autocmd BufWritePre,FileWritePre *.gpg
      \ setlocal bin |
      \ '[,']!gpg --encrypt --default-recipient-self
    " After writing the file, do an :undo to revert the encryption in the
    " buffer, and reset binary file format
    autocmd BufWritePost,FileWritePost *.gpg
      \ silent u |
      \ setlocal nobin
  augroup END

endif " has("autocmd")

" Arduino
autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino" to your .vimrc
