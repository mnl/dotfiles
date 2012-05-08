
"""""""""""""""""""""""""""""""""
" Mickes VIMRC                  "
" Sun Sep 25 23:40:32 CEST 2011 "
"""""""""""""""""""""""""""""""""

" Don't save backups of *.gpg files
set backupskip+=*.gpg
" To avoid that parts of the file is saved to .viminfo when yanking or
" deleting, empty the 'viminfo' option.
set viminfo=

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

" GUI specific options
if has('gui_running')
  colorscheme evening
  set lines=50 columns=100
endif

set tabstop=4

" indenting
 set smartindent
 set autoindent
 set smarttab

syntax on
filetype on

" backups
set backup
silent !mkdir -p ~/.vim/backup
set backupdir=~/.vim/backup/
<<<<<<< HEAD

" misc
colorscheme dusk
=======
!silent colorscheme dusk
>>>>>>> d04fa3b3ad42f6313ebd94c99775ccd3e071d5c9
cnoreabbrev W w
