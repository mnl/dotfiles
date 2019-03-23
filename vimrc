
"""""""""""""""""""""""""""""""""
" Mickes VIMRC                  "
" lör mar 16 22:55:04 CET 2019
"""""""""""""""""""""""""""""""""

" Don't save backups of *.gpg files
set backupskip+=*.gpg
" To avoid that parts of the file is saved to .viminfo when yanking or
" deleting, empty the 'viminfo' option.
set viminfo=

" colors
 set t_Co=256 "my terminals are always colored
 colorscheme wombat256
 " Also good: calmar256-dark, golden, lettuce, colorer, midnight

" GUI specific options
" This replaces .gvimrc
if has('gui_running')
  colorscheme dusk
  set lines=50 columns=100
  set guifont=Monospace
endif

" Make clipboard work as expected
"set clipboard=autoselect,unnamed,exclude:cons\|linux
execute pathogen#infect()

" misc
syntax on
filetype on
set visualbell
set ruler
set hlsearch
set nu

" indenting
 set shiftwidth=2
 set tabstop=2
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
" override readonly
cmap w!! %!sudo tee > /dev/null %

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
  au BufNewFile,BufRead *.ino setfiletype arduino
  au BufNewFile,BufRead *.pde setfiletype arduino
	autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino
	autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino

" Rust
  au Syntax rs	runtime! syntax/rust.vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
silent! iunmap å
silent! iunmap ä
silent! iunmap ö
let g:AutoPairsShortcutFastWrap=''

" Airline
set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
let g:airline_powerline_fonts = 1
set showtabline=2 " Always display the tabline, even if there is only one tab
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'powerlineish'
let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])
let g:airline_skip_empty_sections = 1
"let g:airline_extensions = []

