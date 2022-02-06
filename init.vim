source $HOME/.config/nvim/vim-plug/plugins.vim

" ================ General Config ====================

set number                      "Line numbers are good
set relativenumber              "set relavtive row on the screen"
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
" set gcr=a:blinkon0              "Disable cursor blink
" set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set encoding=UTF-8

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=","
nnoremap <Leader>n :NERDTree <cr>
nnoremap <silent><F3> :MaximizerToggle<cr>
nnoremap <Leader>s :w<cr>
nnoremap <Leader>h :Stdheader<cr>
nnoremap <Leader>q :qa!<cr>
nnoremap <Leader>m :mksession!
nnoremap <Leader>gj :diffget //3<cr>
nnoremap <Leader>gf :diffget //2<cr>
nnoremap <PageDown> :m .+<cr>==
nnoremap <PageUp> :m .-2<cr>==
nnoremap <Leader>tf :Telescope find_files<cr>
nmap <F8> :TagbarToggle<cr>
nnoremap <Leader>rn :set relativenumber <cr>

" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundles.vim
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
endif
au BufNewFile,BufRead *.vundle set filetype=vim

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set noexpandtab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Security ==========================
set modelines=0
set nomodeline

" ================ Custom Settings ========================
so ~/.yadr/vim/settings.vim

"++++++++++++++++++VimSpector++++++++++++++++++++++++
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
let g:maximizer_set_default_mapping = 1

"------------------Debuger remaps--------------------
nnoremap <Leader>rc :call vimspector#Reset()<cr>
nnoremap <Leader>dc :call vimspector#Continue()<cr>
nnoremap <Leader>dw :call vimspector#OmniFuncWatch()<cr>
nnoremap <Leader>re :call vimspector#Restart()<cr>
nnoremap <Leader>db :packadd termdebug
nnoremap <Leader>Te :Termdebug
nnoremap <Leader>u  :VimspectorUpdate<cr>
nnoremap <Leader>c :!gcc -Wall -Werror -Wextra -g <C-r>% -o test
nnoremap <Leader>ca :!gcc -Wall -Werror -Wextra -g <C-r>% libft.a -o test
nnoremap <Leader>cd :!gcc -Wall -Werror -Wextra -g -D BUFFER_SIZE= <C-r>% -o test

"================ Font ==========================
let g:airline_powerline_fonts = 1
" let g:airline_left_sep = " ", "\uE0CE"
let g:airline_left_sep = "\uE0C6 "
let g:airline_right_sep = "\uE0D1"
set clipboard=unnamed
set t_Co=256

" ================= Airline =====================
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ("\uE0B1  ") "' '
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#left_alt_sep = ("\uE0B0")
let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])
let g:vim_debug_disable_mappings = 1
let g:airline_theme = 'codedark'
let g:rainbow_active = 1
let g:termdebug_popup = 0
let g:termdebug_wide = 163

" ========================== Cursor config ========================
let &t_SI = "\<esc>[5 q"  " blinking I-beam in insert mode
let &t_SR = "\<esc>[3 q"  " blinking underline in replace mode
let &t_EI = "\<esc>[ q"  " default cursor (usually blinking block) otherwise]]]"
