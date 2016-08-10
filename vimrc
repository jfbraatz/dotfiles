set nocompatible
"
" watch for changes
"augroup myvimrc
"    au!
"    au BufWritePost .vimrc
"augroup END

set guifont=Menlo\ for\ Powerline
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

"----- Making Vim look good -----
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'edkolev/tmuxline.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/promptline.vim'
Plugin 'ryanoasis/vim-devicons'
"----- Vim as a programmer's text editor -----
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'AndrewRadev/linediff.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jeaye/color_coded'

call vundle#end()

filetype plugin indent on

"------ General Settings -----
set backspace=indent,eol,start
set diffopt+=iwhite     "ignore whitespace during diffs 
set gdefault
set expandtab
set tabstop=4
set shiftwidth=4
set ruler
set relativenumber
set number
set showcmd
"set incsearch  this is to make you jump to the first result when searching
set hlsearch
set wildmenu
set history=500
set autoread
set lazyredraw
set ttyfast
set hidden
set showmatch
set scrolloff=8
set cursorline
"set noswapfile
:autocmd FileType qf wincmd J

let mapleader=","

inoremap  jk <ESC>
vnoremap jk <ESC>
cnoremap jk <ESC>

"don't skip over wrapped lines in Normal mode
nnoremap j gj
nnoremap k gk

"brace completion
inoremap {<CR> {<CR>}<Esc>O

"Y yanks to end of line
nnoremap Y y$

"for moving between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

"Ctrl-s to save
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

"Ctrl-q to save and quit all windows
nnoremap <C-Q> :wqa<CR>

"backspace without entering insert mode
nnoremap <BS> hx

"always paste to match surrounding indentation
"nnoremap p ]p

"scroll 5 lines at a time
nnoremap <C-Y> 5<C-Y>
nnoremap <C-E> 5<C-E>

"ctags reference jumps will move jump location to top of screen
nnoremap <C-]> <C-]>zt
nnoremap <C-t> <C-t>zt

"<Leader>] to open tag in preview window
nnoremap <Leader>] <C-W>}

"eaiser moving of code blocks
vnoremap < <gv
vnoremap > >gv

syntax on

set mouse=a

"up and down for moving in Quickfix list
no <down> :cn<CR>
no <up> :cp<CR>

"disable arrow keys
no <right> <Nop>
no <left> <Nop>

ino <down> <Nop>
ino <up> <Nop>
ino <right> <Nop>
ino <left> <Nop>


"smart indent when entering insert mode with i on empty lines
function! IndentWithI()
	if len(getline('.')) == 0
		return "\"_cc"
	else
		return "i"
	endif
endfunction
nnoremap <expr> i IndentWithI()

""" SYSTEM CLIPBOARD COPY & PASTE SUPPORT
set pastetoggle=<F2> "F2 before pasting to preserve indentation
"Copy paste to/from clipboard
vnoremap <C-c> "*y
map <silent><Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
map <silent><Leader><S-p> :set paste<CR>O<esc>"*]p:set nopaste<cr>"

" leader r to reload .vimrc
map <silent><Leader>r :source ~/.vimrc<CR>

" leader h to disable search highlighting
map <silent><Leader>h :nohls<CR>

" leader s to search current word with Ag
map <silent><Leader>s yiw:Ag! <C-R>"<CR><C-L>

" leader v to edit .vimrc in new tab
map <silent><Leader>v :tabe ~/.vimrc<CR>


"----- PLugin-Specific settings -----

"----- altercation/vim-colors-solarized settings -----

set background=dark
"let g:solarized_termcolors=256
colorscheme solarized
call togglebg#map("<F5>")

"----- bling/vim-arline settings -----

set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#enabled = 1
let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled = 1

let airline#extensions#whitespace#enabled = 0
let g:airline_detect_whitespace = 0
let g:airline_theme='bubblegum'

"----- jistr/vim-nerdtree-tabs -----
" Open/close NERDTree Tabs with ,t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
let g:nerdtree_tabs_open_on_console_startup = 0
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

"----- scrooloose/syntastic settings -----
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = '▲'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
augroup mySyntastic
	au!
	au FileType tex let b:syntastic_mode = "passive"
augroup END

"----- tagbar -----
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
let g:tagbar_width=30
let g:tagbar_show_linenumbers=2
"autocmd VimEnter * nested :call tagbar#autoopen(1)
"autocmd BufEnter * nested :call tagbar#autoopen(0)
noremap <silent> <Leader>y :TagbarToggle<CR>

"----- YouCompleteMe -----
"set runtimepath-=~/.vim/bundle/YouCompleteMe
"let g:ycm_show_diagnostics_ui=0
"let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

"----- color_coded -----
let g:color_coded_enabled=1    
