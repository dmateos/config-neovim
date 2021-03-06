"""""""""
" display

" jellybeans theme, with black background instead of grey
let g:jellybeans_overrides = {"background": {"guibg": "000000"}}
let g:jellybeans_use_term_italics = 1
colorscheme jellybeans

set nofoldenable

" vertical split color
autocmd ColorScheme * highlight VertSplit ctermfg=235 ctermbg=235 cterm=NONE

" status line color
autocmd ColorScheme * highlight StatusLine ctermfg=250 ctermbg=238 cterm=NONE
autocmd ColorScheme * highlight StatusLineNC ctermfg=black ctermbg=235 cterm=NONE

" highlight current cursor line, with a notch after column 80
set cursorline
set colorcolumn=81

" show line numbers
set number

" I = skip intro message on startup
" F = skip file info prompt when opening file
set shortmess=IF

" Smart indent
set smartindent

" display invisible characters as per 'listchars' option
"set list
set listchars=tab:>-,trail:-


""""""""""
" keyboard

" change <Leader> from default '\' to home-row-friendly ';'
let mapleader = ";"

" arrow keys navigate splits in normal mode; use hjkl for movement.
nmap <Up> <C-W><Up>
nmap <Down> <C-W><Down>
nmap <Left> <C-W><Left>
nmap <Right> <C-W><Right>

" move lines up/down, reindenting
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" reselect visual block after shifting indentation
vnoremap < <gv
vnoremap > >gv


"""""""
" mouse

" Mouse for scrolling etc in console.
" a = normal + visual + insert + command-line + help files
set mouse=a


""""""""""
" behavior

" indent with two spaces by default
set expandtab
set tabstop=2
set softtabstop=0 " disable
set shiftwidth=0 " when zero, the tabstop value is used

" use clipboard for all operations, without explicit +/* registers.
set clipboard+=unnamedplus

" keep hidden/background buffers; allow unsaved changes etc.
set hidden

" lines to keep above/below cursor when scrolling
set scrolloff=3

" Show effect of command incrementally; :%s/foo/bar/g etc
"nosplit": Shows the effects of a command incrementally, as you type.
"split"  : Also shows partial off-screen results in a preview window.
set inccommand=split


""""""""""""
" file types

" assume shell scripts as bash; fixes $(subcommand) syntax highlighting.
" https://github.com/neovim/neovim/blob/253f6f3b/runtime/syntax/sh.vim#L16
let g:is_bash=1

autocmd FileType ruby inoreabbrev <buffer> pry! require "pry"; binding.pry

"""""""""
" plugins

" ctrlp.vim
" when opening multiple files, prompt for tab/split/etc.
let g:ctrlp_arg_map = 1
nnoremap <leader>ga :CtrlP <cr>

" vim-go
if executable("goimports")
  let g:go_fmt_command = "goimports"
endif

" nerd-tree
nmap <silent> <leader>n :NERDTree<CR>
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeIgnore = ['\.pyc$']
set completeopt=menu
let g:pymode_python = 'python3'
let g:pymode_lint_ignore = ["E501", "C901"]

