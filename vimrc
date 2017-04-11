" :help window-moving
"
"

colorscheme default 
"syntax on
syntax enable

set ts=2
set shiftwidth=2
set expandtab
set tabstop=2
"set nowrap
"set nowrapscan
set mouse=nvi
set hlsearch
set smartcase

" Autocomplete mode
set wildmode=longest,list,full
set wildmenu

" Blocket Platform
" Correct the file type
autocmd BufNewFile,BufRead bconf.txt.* set filetype=cfg
autocmd BufNewFile,BufRead *.html.tmpl set filetype=html
autocmd BufNewFile,BufRead *.sql.tmpl set filetype=sql

" Line Numbers
set rnu
if &diff
	set nu
endif

nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

" open newline without entering insert mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
" ctrl + n opens nerdtree
map <C-n> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
" F3 uses Ack! of word under cursor
map <F3> "myiw:Ag! <C-r>m<CR>
map <F5> "myiw:Ag! "def <C-r>m<CR>"
map <F7> :RuboCop<CR>
" Scroll without moving the cursor
map <C-Up> <C-e>
map <C-Down> <C-y>
imap <C-Up> <C-o><C-e>
imap <C-Down> <C-o><C-y>

map \ <Plug>(easymotion-prefix)

map <Leader>ap $p
map <Leader>riw viwp
map <Leader>y "+y
map <Leader>p "+p

map <Leader>w :w<CR>

map <Leader>ovrc :tabe ~/.vimrc<CR>
map <Leader>svrc :source ~/.vimrc<CR>

map <Leader>sp :set paste<CR>
map <Leader>snp :set nopaste<CR>
 
map <Leader>fmi :set foldmethod=indent<CR>
map <Leader>fms :set foldmethod=syntax<CR>
map <Leader>fmm :set foldmethod=manual<CR>
map <Leader>fl0 :set foldlevel=0<CR>
map <Leader>fl1 :set foldlevel=1<CR>
map <Leader>fl2 :set foldlevel=2<CR>
map <Leader>fl3 :set foldlevel=3<CR>
map <Leader>fl9 :set foldlevel=9<CR>

" Save as a new file name and open it
command! -nargs=1 WE :w <args> | :e <args>
command! -nargs=1 WED :w %:h/<args> | :e %:h/<args>
" Open vimrc in a split window
command! Vimrc :sp $MYVIMRC

"auto indent
set ai
set si

" fold method
set foldmethod=indent
" za zA zM zR
" set foldmethod=manual
" zf3j

" git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=55

" ctrlp ignores
" F5 refresh cache
let g:ctrlp_max_files = 20000
let g:ctrlp_max_depth = 40
let g:ctrlp_custom_ignore = 'tmp/\|node_modules\|client/node_modules\|DS_Store\|git'

let &tags = './tags,tags,' . substitute(expand("%:p:h"), "\(^\/home\/bmentges\/dev\/.*/\).*$", "\1", "")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
call vundle#begin('~/.vim/bundle/')

" let Vundle manage Vundle
" required! 

Plugin 'morhetz/gruvbox'
" colorscheme gruvbox

Plugin 'mhinz/vim-startify'

Plugin 'gmarik/vundle'

Plugin 'kien/ctrlp.vim'

Plugin 'airblade/vim-gitgutter'
let g:gitgutter_realtime = 0
" usage: :GitGutterDisable :GitGutterEnable :GitGutterToogle
" jump to next unk ]h previous hunk [h
"
Plugin 'tpope/vim-fugitive'
"[2014-10-27 17:05:17] Helptags:
"[2014-10-27 17:05:17] :helptags /home/bmentges/.vim/bundle/vundle/doc/
"[2014-10-27 17:05:17] :helptags /home/bmentges/.vim/bundle/ctrlp.vim/doc/
"[2014-10-27 17:05:17] :helptags /home/bmentges/.vim/bundle/vim-gitgutter/doc/
"[2014-10-27 17:05:17] :helptags /home/bmentges/.vim/bundle/vim-fugitive/doc/

Plugin 'scrooloose/syntastic'
" :SyntasticCheck pylint

Plugin 'rking/ag.vim'
" :Ag [options] {pattern} [{directory}]
" Search recursively in {directory} (which defaults to the current directory)
" for the {pattern}.
"
" Files containing the search term will be listed in the split window, along
" with the line number of the occurrence, once for each occurrence. [Enter] on
" a line in this window will open the file, and place the cursor on the
" matching line.
"
" Just like where you use :grep, :grepadd, :lgrep, and :lgrepadd, you can use
" :Ag, :AgAdd, :LAg, and :LAgAdd respectively. (See doc/ag.txt, or install and
" :h Ag for more information.)

Plugin 'scrooloose/nerdtree'

Plugin 'regedarek/ZoomWin'
" <c-w>o ZoomWin in and out

Plugin 'vim-scripts/tComment'
" gcc to comment one line
" gc to multiple visual lines

Plugin 'vim-utils/vim-ruby-fold'

Plugin 'editorconfig/editorconfig-vim'

Plugin 'ngmy/vim-rubocop'

Plugin 'easymotion/vim-easymotion'

Plugin 'mickaobrien/vim-stackoverflow'

Plugin 'tpope/vim-surround'

Plugin 'leafgarland/typescript-vim'

Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
" 
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

" Syntastic Checkers
let g:syntastic_enable_signs=1                                                                     
let g:syntastic_auto_jump=0                                                                        
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'                           
let g:syntastic_mode_map = { 'mode': 'active',                                                     
                           \ 'active_filetypes': ['python', 'php', 'js'],                                
                           \ 'passive_filetypes': ['puppet', 'jsx'] }                                     

let g:syntastic_python_pylint_args = "--disable=W0312,C0111"
let g:syntastic_ruby_checkers = ['rubocop', 'ruby-lint']
let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_aggregate_errors = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>


" vim startify
let g:startify_change_to_vcs_root = 1
let g:startify_bookmarks = [ 
        \ { 'co': '~/projetos/ev/checkout' },
        \ { 'am': '~/projetos/ev/amsterdam' },
        \ { 'lb': '~/projetos/ev/library' },
        \ { 'cb': '~/projetos/ev/opsworks-cookbooks' },
        \]
let g:startify_list_order = [
        \ ['   My most recently used files in the current directory:'],
        \ 'dir',
        \ ['   My most recently', '   used files'],
        \ 'files',
        \ ['   These are my bookmarks:'],
        \ 'bookmarks',
        \ ['   These are my sessions:'],
        \ 'sessions',
        \ ]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"yank filename
nmap yp :let @" = expand("%") <CR>

" Identando JSON no vim:
" 
" Pedro Lira [14:43]
" :%!python -m json.tool
" 
" Pedro Lira [14:43]
" Identando XML no vim:
" 
" Pedro Lira [14:44]
" :%!xmllint --format -

" Tab navigation
noremap <C-Right> :tabn<CR> 
inoremap <C-Right> <esc>:tabn<CR><Insert> 
noremap <C-Left> :tabprev<CR> 
inoremap <C-Left> <ESC>tabprev<CR><Insert>
noremap <f9> :set filetype=html<CR>

if filereadable( expand("$HOME/.vim/bundle/gruvbox/colors/gruvbox.vim") )
	colorscheme gruvbox
endif
set background=dark

" To work webpack --watch
"Vim
"On some machines Vim is preconfigured with the backupcopy option set to auto. This could potentially cause problems with the system’s file watching mechanism. Switching this option to yes will make sure a copy of the file is made and the original one overwritten on save.
set backupcopy=yes

" To allow gF to work based on current FileType
" http://stackoverflow.com/questions/33093491/vim-gf-with-file-extension-based-on-current-filetype
augroup suffixes
    autocmd!

    let associations = [
                \["javascript", ".js,.javascript,.es,.esx,.json,.jsx"],
                \["python", ".py,.pyw"]
                \]

    for ft in associations
        execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
    endfor
augroup END

if !exists('*FoldLevelDependingOnStartFile')
  function FoldLevelDependingOnStartFile()
    if @% == ""
      " No filename for current bugger
      set foldlevel=9
    else
      set foldlevel=0
    endif
  endfunction
endif

au VimEnter * call FoldLevelDependingOnStartFile()

" instead of disabling, set swapfiles to tmp directory inside .vim
" we try to create it if it doesnt exist
if empty(glob('~/.vim/vim_backups'))
  silent !mkdir ~/.vim/vim_backups > /dev/null 2>&1
  echo "Created backup directory: ~/.vim/vim_backups"
endif


set dir=~/.vim/vim_backups " both dir and directory works - :h 'directory' - vim 8
set directory=~/.vim/vim_backups " both dir and directory works - :h 'directory' - vim 8
set backupdir=~/.vim/vim_backups
set undodir=~/.vim/vim_backups

set swapfile "I want swap files to be there in case of a crash/reboot/network-down
set backup "changed my mind on backup files. want those too, but hidden in the .vim/vim_backups dir.

"" Fix to include dotfiles for ctrlp and NERDTree
let g:ctrlp_show_hidden=1
let NERDTreeShowHidden=1
