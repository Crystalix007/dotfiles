let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0

call plug#begin()

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zchee/deoplete-clang'
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'uplus/vim-clang-rename'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'vim-pandoc/vim-pandoc-syntax'

nnoremap <c-p> :FZF<cr>

Plug 'junegunn/vim-peekaboo'

call plug#end()

let g:deoplete#enable_at_startup = 1
" deoplete tab-complete

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

let g:airline_powerline_fonts = 1
let g:airline_extensions = []

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

let g:pandoc#syntax#conceal#use = 1
let g:mkdp_refresh_slow = 1
