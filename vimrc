" my vimrc

" general
let g:current_desktop = system("echo $XDG_CURRENT_DESKTOP")
set nocompatible
set showcmd
set timeoutlen=1500 ttimeoutlen=0
set confirm
set smartcase ignorecase incsearch hlsearch
set number relativenumber
set wildmode=full wildmenu
set laststatus=2
set lazyredraw
"set history=100000
set backspace=2
set scrolloff=3
set undofile undodir=/home/jesse/.vim/undo undolevels=100000 undoreload=1000000
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
      \exec "normal! g'\"" | endif

" indent
set shiftwidth=4 tabstop=4 smarttab
function! TabMode(size, expand)
  execute 'setlocal shiftwidth=' . a:size . ' tabstop=' . a:size
  if a:expand==1
    setlocal expandtab
  else
    setlocal noexpandtab
  endif
endfunction

autocmd FileType php call TabMode(4, 0)
autocmd FileType cpp,java,css call TabMode(4, 1)
autocmd FileType vim,sh,python call TabMode(2, 1)

" compiling and executing
let g:VETerm="konsole -e /usr/bin/zsh -c"
let g:VEExternalTerm=1
"let g:ycm_show_diagnostics_ui = 0
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>>'
"let g:ycm_enable_diagnostic_signs = 0
"let g:ycm_enable_diagnostic_highlighting = 0

" visual
syntax on
"set colorcolumn=90
let maxcolumn=88
set cursorline
highlight ColorColumn ctermbg=magenta
let php_sql_query = 1

" highlight long lines
"call matchadd('ColorColumn', '\%' . maxcolumn . 'v', 100)

"highlight ColorColumn ctermbg=red ctermfg=blue
"exec 'set colorcolumn=' . join(range(2, 80, 3), ',')
set t_Co=256
if has('gui_running')
  "colorscheme wombat256
  colorscheme kellys
  set guioptions-=m
  set guioptions-=M
  set guioptions-=T
  set guioptions-=e
  set guioptions+=c
  set guifont=Consolas\ 13
else
  colorscheme impact
  "hi Normal ctermbg=None
endif
" | ¦ ┆ │
set list
execute "set listchars=tab:¦\\ ,trail:\uB7,nbsp:~"
command! SizeMed set lines=31 | set columns=113
command! SizeBig set lines=40 | set columns=150
command! SizeGreat set lines=45 | set columns=178

" remember view
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" markdown
let g:instant_markdown_autostart = 0

" general keymaps
let g:sqlutil_load_default_maps = 0
if !has('gui_running')
  let c='a'
  while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    exec "cmap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
  endwhile

  imap <m-;> oi
  inoremap Â§ <C-w>
endif

let mapleader = ','
nnoremap \ ,
cnoremap <A-p> <C-c>
inoremap <A-p> <Esc>
nnoremap <Leader><Leader> <Leader>
nnoremap <Leader>vq :q<CR>
nnoremap <Leader>vw :w<CR>
nnoremap <Leader>s :w<CR>
nnoremap <Leader>vv :e ~/.vim/vimrc<CR>
nnoremap <Leader>r :VERun<CR>
nnoremap <Leader>vr :e<CR>
nnoremap <Leader>ep :ProjectsTree<CR>
inoremap <C-Backspace> <C-w>
inoremap <C-i> <C-k>
inoremap <A-n> <Down>
inoremap <A-p> <Up>

nnoremap <Leader>wo :only<CR>
nnoremap <Leader>wsp <Plug>SaveWinPosn
nnoremap <Leader>wrp <Plug>RestoreWinPosn
inoremap <A-[> <Esc>
cnoremap <A-[> <C-c>
inoremap <C-l> <Esc>
cnoremap <C-l> <C-c>

" buffers
nnoremap <Leader>b :Buffers<CR>
nnoremap <C-x>b :Buffers<CR>

nnoremap -h :nohlsearch<CR>

nnoremap <Leader>tn :tabe<CR>
nnoremap <Leader>tc :tabclose<CR>
nnoremap <C-n> gt
nnoremap <C-p> gT

nnoremap ` '
nnoremap ' `
nnoremap ZZ zz

" java/eclim mappings
nnoremap <Leader>jc :JavaCorrect<CR>
nnoremap <Leader>ji :JavaImport<CR>
nnoremap <Leader>jm :JavaImpl<CR>
nnoremap <Leader>jv :Validate<CR>

"inoremap <C-m> <Esc>a<Enter>
"inoremap <Enter> <Esc>a<Enter>

vnoremap <Leader>eb :Source<CR>
nnoremap <Leader>eb :%Source<CR>

nnoremap <Leader>cd :cd %:p:h<CR>
nnoremap <Leader>lcd :lcd %:p:h<CR>
nnoremap <Leader>ve :let filename=expand("%:p")<CR>q:ie <C-r>=filename<CR><Esc>
nnoremap <Leader>ne :NERDTree<CR>
exec "nnoremap <Leader>no :NERDTreeFromBookmark "

" make vim emacs 'compatible'
nnoremap ¼ gg
nnoremap ¾ G
inoremap <A-BS> <C-w>
cnoremap <A-BS> <C-w>

vmap s S

" aliases
"cnoreabbrev p NERDTreeFromBookmark

" completion
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_force_overwrite_completefunc=0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_use_ultisnips_completer=0
let g:UltiSnipsExpandTrigger='<Tab>'
let g:ycm_add_preview_to_completeopt = 0
inoremap <C-x><C-o> <C-x><C-o><C-p>
let g:jedi#rename_command='<leader>jr'
"let g:jedi#auto_vim_configuration=0
let g:EclimCompletionMethod = 'omnifunc'
let g:ycm_filetype_specific_completion_to_disable={'python':1}
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:jedi#force_py_version = 3
"let g:jedi#auto_close_doc=1
"let g:ycm_auto_trigger=0
set completeopt-=preview
set completeopt+=longest

" [other] plugin maps
let g:multi_cursor_next_key='<C-j>'

" bundle/vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'surround.vim'
Plugin 'The-NERD-Commenter'
Plugin 'sollidsnake/verun'
Plugin 'sollidsnake/vterm'
Plugin 'UltiSnips'
Plugin 'colorselector'
Plugin 'xterm-color-table.vim'
Plugin 'Yggdroot/indentLine'
"Plugin 'neocomplcache'
Plugin 'NERD_tree-Project'
"Plugin 'gioele/vim-autoswap'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'sollidsnake/jedi-vim-test'
Plugin 'scrooloose/nerdtree'
"Plugin 'NERD_tree-Project'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'LargeFile'
Plugin 'tmhedberg/matchit'
Plugin 'SQLUtilities'
Plugin 'align'
"Plugin 'Syntastic'
"Plugin 'easytags.vim'
Plugin 'xolox/vim-misc'
"Plugin 'project.vim'
"Plugin 'ProjectTag'
Plugin 'DfrankUtil'
Plugin 'vimprj'
Plugin 'ctrlp.vim'
Plugin 'EasyMotion'
Plugin 'vcscommand.vim'
Plugin 'bling/vim-airline'
Plugin 'genutils'
Plugin 'multiselect'
Plugin 'php.vim'
"Plugin 'hdima/python-syntax'
Plugin 'plasticboy/vim-markdown'
Plugin 'instant-markdown.vim'
Plugin 'fugitive.vim'
"Plugin 'Shougo/neocomplcache.vim'
Plugin 'Shougo/vimshell.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'unite.vim'
"Plugin 'SuperTab'
Plugin 'jaxbot/semantic-highlight.vim'

call vundle#end()

filetype plugin indent on

" statusline
let g:airline_theme = 'lucius'
let g:airline#extensions#whitespace#checks = [ 'trailing' ]

" source
if !exists('*SourceRange')
  function! SourceRange() range
      let tmpsofile = tempname()
      call writefile(getline(a:firstline, a:lastline), l:tmpsofile)
      execute "source " . l:tmpsofile
      call delete(l:tmpsofile)
  endfunction
  command! -range Source <line1>,<line2>call SourceRange()
endif

" backup options
let g:bkdir = '/home/jesse/.vimbk/'
let g:bk_max_size = '500000'

function! SaveBk()
  let a:size = getfsize(expand('%:p'))
  let a:bkfile = substitute(expand("%:p"), "/", "\\\\%", "g")
  let a:bkfile = substitute(a:bkfile, " ", "\\\\ ", "g") " escape espaces
  if g:bk_max_size > a:size
    execute 'silent w ' g:bkdir . a:bkfile . '__' . strftime('%Y%m%d-%H%M%S') . '.bak'
  endif
endfunction

let g:ycm_qt_location = '~/code/learn/cpp/qt5-vim-ycm-completion.py'
function! YcmQt()
  let s:folder = expand('%:p:h')
  let command = "silent! !cp " . g:ycm_qt_location . " " . s:folder . '/.ycm_extra_conf.py'
  execute command
  echom command
  redraw!
endfunction

command! SaveBk call SaveBk()
autocmd BufRead,BufWrite *.* SaveBk

" projects
let httpDir = '/home/jesse/projects/http/'
let g:ctrlp_map='<C-a>'
command! StartEclim execute "silent !nohup /usr/share/eclipse/eclimd &"

command! GoHttp exec 'cd ' . httpDir
command! Work e ~/documents/work/today.txt
command! Http execute "!sudo systemctl start httpd mysqld"
command! TreeEclipse e ~/projects/eclipse-workspace/
command! YcmQt call YcmQt()

nnoremap <Leader>gp :GoHttp<CR>
