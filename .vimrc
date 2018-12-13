set nocompatible              " required
filetype off                  " required
set number
set modeline
set background=dark
syntax on
filetype indent plugin on
set autoindent
imap jj <Esc>
set cursorline
set mouse=a

" Highlight search, unhighlight on double esc
set hlsearch
nnoremap <esc><esc> :silent! nohls<cr>

" virtual tabstops using spaces
"set shiftwidth=4
"set softtabstop=4
"set tabstop=8
"set expandtab
":highlight MixedIndent ctermbg=red guibg=red
":2match MixedIndent /^[[:space:]]*\t/

" allow toggling between local and default mode
function TabToggle(...)
    if a:0 > 0
        let tabtype = a:1 " 0: switch to soft tabs, 1: switch to hard tabs
    else
        let tabtype = &expandtab
    endif

    if tabtype
        set shiftwidth=8
        set softtabstop=0
        set noexpandtab
        echo "Tabs: HARD"
        :highlight MixedIndent ctermbg=red guibg=red
        :2match MixedIndent /^\t*\zs \+/
    else
        set shiftwidth=4
        set softtabstop=4
        set expandtab
        echo "Tabs: SOFT"
        :highlight MixedIndent ctermbg=red guibg=red
        :2match MixedIndent /^[[:space:]]*\t/
    endif
endfunction
nmap <F9> mz:execute TabToggle()<CR>'z

"Set tab mode to soft:
autocmd VimEnter * :execute TabToggle(0)


" Shortcut for reformatting
map <F7> mzgg=G`z

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Change filesystem to read-write
function SetReadWrite()
    !sudo mount -o remount,rw /
    :set noreadonly
endfunction
command ReadWrite exec SetReadWrite()

" Workaround for vim memory leak caused by calling match command
if version >= 702
    autocmd BufWinLeave * call clearmatches()
endif


let g:minimap_highlight='Visual'

" START - Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    if executable('git')
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
        let iCanHazVundle=0
    else
        echo "Git not found. Skipping vundle install."
    endif
endif
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'kien/ctrlp.vim'
if has('python2') && (executable('catkin') || executable('catkin_make'))
    Plugin 'taketwo/vim-ros'
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :PluginInstall
endif

colorscheme gruvbox
let g:airline#extensions#tabline#enabled = 1
"let g:airline_right_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_left_alt_sep= ''
"let g:airline_left_sep = ''
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#buffer_nr_show = 1

" Show hard/soft tab status in bottom bar
:let g:airline_section_b = '%{airline#util#wrap(airline#extensions#hunks#get_hunks(),0)}%{airline#util#wrap(airline#extensions#branch#get_head(),0)}%{ &expandtab?"  Tab:S":"  Tab:H"}'


" Highlight trailing whitespace
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+\%#\@<!$/
:au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
:au InsertLeave * match ExtraWhitespace /\s\+$/


if !&diff " Actions to perform at start (except when opened as vimdiff)
    " Start NERDTree and Minimap on startup
    autocmd VimEnter * NERDTree
    autocmd VimEnter * Minimap
    " Go to previous (last accessed) window.
    autocmd VimEnter * wincmd w
    " Remap q to qa for quickly exiting
    cnoremap q qa

endif


