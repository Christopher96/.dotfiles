" RUNTIME {{{

:runtime postload/*

" }}}

" AUTOCOMMANDS {{{

" Resize splits when window is resized
au VimResized * exe "normal! \<c-w>="

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
	au!
	au BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$") |
				\     execute 'normal! g`"zvzz' |
				\ endif
augroup END

augroup reload_vimrc
	autocmd!
	autocmd BufWritePost $MYVIMRC breakdel *
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" let keybinds = '$HOME/.vim/postload/keybinds.vim'
"
" augroup reload_keybinds
"     autocmd!
"     autocmd BufWritePost keybinds breakdel *
"     autocmd BufWritePost keybinds source keybinds
" augroup END

" }}}

" FOLDING {{{

set foldenable
set foldlevelstart=1
set foldmarker={{{,}}}
set foldmethod=marker

" }}}

" SETTINGS {{{

set path+=**
set wildmenu
set nocompatible
set nu
set ignorecase
set smartcase
set hlsearch          
set encoding=utf8    
set fillchars=vert:\ 
set autoread

set tabstop=4     " Size of a hard tabstop (ts).
set shiftwidth=4  " Size of an indentation (sw).
set softtabstop=4 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
set noexpandtab   " Always uses tabs instead of space characters (noet).
set autoindent    " Copy indent from current line when starting a new line (ai).

function! UseSpaces()
	set tabstop=2     " Size of a hard tabstop (ts).
	set shiftwidth=2  " Size of an indentation (sw).
	set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
	set expandtab     " Always uses spaces instead of tab characters (et).
	set autoindent    " Copy indent from current line when starting a new line.
	set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
endfunction

au! BufWrite,BufEnter *.tsx,*.ts call UseSpaces()

set backup
set noswapfile
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
set undodir=~/.vim/tmp

filetype plugin on
filetype off                  " required

" }}}

" COLORS {{{

syntax enable

" }}}

" PLUGINS {{{

call plug#begin('~/.vim/plugged')

" Helpers
Plug 'vim-scripts/tComment'
Plug 'mattn/emmet-vim'
Plug 'KabbAmine/vCoolor.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'tmhedberg/matchit'
Plug 'lambdalisue/suda.vim'

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'HerringtonDarkholme/yats.vim'

" Theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'ryanoasis/vim-devicons'

" Autocomplete
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'

" Nvim
Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" Other
Plug 'djoshea/vim-autoread'
Plug 'rbgrouleff/bclose.vim'

call plug#end()

" }}}

" PLUGINS {{{

" Auto-pairs
let g:AutoPairsMultilineClose = 0
let g:AutoPairsFlyMode = 0

"" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='zenburn'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
"

" }}}

" COC EXTENSIONS {{{

let g:coc_global_extensions = [
			\ 'coc-ccls',
			\ 'coc-ultisnips',
			\ 'coc-snippets',
			\ 'coc-tsserver',
			\ 'coc-eslint', 
			\ 'coc-prettier', 
			\ 'coc-json', 
			\ 'coc-java', 
			\ ]

"}}}
