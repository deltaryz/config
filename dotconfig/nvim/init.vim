" Import other configs
let g:nvim_config_root = stdpath('config')
let g:config_file_list = ['coc.vim']

for f in g:config_file_list
    execute 'source ' . g:nvim_config_root . '/' . f
endfor

" Use `fd` to escape insert mode 
:imap fd <Esc>

" use `;;` to advance buffers
:map ;; :bn<cr>

" General config
syntax on
syntax enable
filetype off
set nocompatible
set number
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set signcolumn=yes

autocmd FileType * set formatoptions-=cro

" Ctrl-S to save while in insert mode
imap <C-s> <Esc>:w!<CR>i
nmap <C-s> <Esc>:w!<cr>

" Ctrl-\ to reload config
nnoremap <C-\> <Esc>:so ~/.config/nvim/init.vim<CR>

" Ctrl-P to format
nmap <C-p> <Esc>:CocCommand prettier.formatFile<cr>

" Bootstap Plugins
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
	silent execute '!curl -fLo ' . autoload_plug_path . ' --create-dirs 
		\ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

let pluginsPath = stdpath('data') . '/plugged'

autocmd VimEnter *
    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \|   PlugInstall --sync | q
    \| endif

call plug#begin(pluginsPath)

" PLUGINS
" -------

Plug 'HerringtonDarkholme/yats.vim'
Plug 'wellle/tmux-complete.vim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'psliwka/vim-smoothie'
" Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':CocInstall coc-tabnine coc-tsserver coc-json coc-git coc-fish coc-prettier coc-html coc-css coc-highlight'}


" -------
" PLUGINS

call plug#end()
unlet pluginsPath

" PLUGIN CONFIG
" -------------

" coc
hi CocFloating ctermbg=237
hi Pmenu ctermbg=54
hi Pmenu ctermfg=white
highlight! LineNr ctermfg=blue
highlight! link SignColumn none
hi DiffAdd ctermbg=234 ctermfg=green
hi GitGutterAdd ctermbg=234 ctermfg=green
hi DiffDelete ctermbg=234 ctermfg=red
hi GitGutterDelete ctermbg=234 ctermfg=red
hi DiffChange ctermbg=234 ctermfg=yellow
hi GitGutterChange ctermbg=234 ctermfg=yellow

let g:gitgutter_sign_allow_clobber = 1
let g:gitgutter_set_sign_backgrounds = 1

let g:airline_theme='raven'

" Deoplete
let g:deoplete#enable_at_startup = 1

" tmux-complete
let g:tmuxcomplete#trigger = ''

" statusline
" set noshowmode
" set noruler
" set laststatus=0
" set noshowcmd
" set cmdheight=1

" -------------
" PLUGIN CONFIG


