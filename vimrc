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
set history=100000
set backspace=2
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
autocmd FileType cpp call TabMode(4, 1)
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
call matchadd('ColorColumn', '\%' . maxcolumn . 'v', 100)

"highlight ColorColumn ctermbg=red ctermfg=blue
"exec 'set colorcolumn=' . join(range(2, 80, 3), ',')
set t_Co=256
if has('gui_running')
  "colorscheme wombat256
  colorscheme darkspectrum
  set guioptions-=m
  set guioptions-=T
  set guioptions-=e
  set guioptions+=c
  set guifont=Inconsolata\ 12
else
  colorscheme distinguished
  "hi Normal ctermbg=None
endif
" | ¦ ┆ │
set list
execute "set listchars=tab:¦\\ ,trail:\uB7,nbsp:~"
command! SizeMed set lines=31 | set columns=113

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
cnoremap <A-p> <C-c>
inoremap <A-p> <Esc>
nnoremap <Leader><Leader> <Leader>
nnoremap <Leader>vq :q<CR>
nnoremap <Leader>vw :w<CR>
nnoremap <Leader>s :w<CR>
nnoremap <Leader>vv :e ~/.vimrc<CR>
nnoremap <Leader>r :VERun<CR>
nnoremap <Leader>vr :e<CR>
inoremap <C-Backspace> <C-w>

nnoremap <Leader>wsp <Plug>SaveWinPosn
nnoremap <Leader>wrp <Plug>RestoreWinPosn

nnoremap -h :nohlsearch<CR>

nnoremap <Leader>tn :tabe<CR>
nnoremap <Leader>tc :tabclose<CR>
nnoremap <C-n> gt
nnoremap <C-p> gT
nnoremap ` '
nnoremap ' `

inoremap <C-m> <Esc>a<Enter>
inoremap <Enter> <Esc>a<Enter>

vnoremap <Leader>eb :Source<CR>
nnoremap <Leader>eb :%Source<CR>

nnoremap <Leader>cd :cd %:p:h<CR>
nnoremap <Leader>lcd :lcd %:p:h<CR>
nnoremap <Leader>ve :let filename=expand("%:p")<CR>q:ie <C-r>=filename<CR><Esc>
nnoremap <Leader>ne :NERDTree<CR>
exec "nnoremap <Leader>no :NERDTreeFromBookmark "

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
let g:jedi#auto_vim_configuration=0
let g:EclimCompletionMethod = 'omnifunc'
"let g:ycm_filetype_specific_completion_to_disable={'php':1}
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:jedi#force_py_version = 3
let g:jedi#auto_close_doc=1
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
Plugin 'gioele/vim-autoswap'
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
Plugin 'easytags.vim'
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
Plugin 'hdima/python-syntax'
Plugin 'plasticboy/vim-markdown'
Plugin 'instant-markdown.vim'
Plugin 'fugitive.vim'

call vundle#end()

filetype plugin indent on

" statusline
let g:airline_theme = 'lucius'
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]

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

command! SaveBk call SaveBk()
silent! autocmd BufRead,BufWrite *.* SaveBk

" projects
let httpDir = '/home/jesse/projects/http/'
let g:ctrlp_map='<C-a>'
command! GoHttp exec 'cd ' . httpDir
command! FtpCentral e ftp://localdados.com/httpdocs/
command! Work e ~/documents/work/today.txt
command! Http execute "!sudo systemctl start httpd mysqld"
nnoremap <Leader>gp :GoHttp<CR>
