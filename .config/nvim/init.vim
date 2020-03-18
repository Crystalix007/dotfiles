let mapleader = "\<Space>"

call plug#begin('~/.vim/plugged')

	" Plug 'jackguo380/vim-lsp-cxx-highlight', { 'highlight': { 'lsRanges' : v:true }, }
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'Shougo/deoplete-lsp'
	Plug 'Shougo/denite.nvim'
	Plug 'Shougo/echodoc.vim'
	Plug 'junegunn/vim-easy-align'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'uplus/vim-clang-rename'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'easymotion/vim-easymotion'
	Plug 'tpope/vim-eunuch'
	Plug 'tpope/vim-fugitive'
	Plug 'rbong/vim-flog'
	Plug 'tpope/vim-unimpaired'
	Plug 'peterhoeg/vim-qml'
	Plug 'rhysd/vim-clang-format'
	Plug 'vim-scripts/LargeFile'
	Plug 'ntpeters/vim-better-whitespace'
	Plug 'liuchengxu/vista.vim'
	Plug 'wesQ3/vim-windowswap'
	Plug 'junegunn/limelight.vim'
	Plug 'nightsense/snow'
	Plug 'junegunn/goyo.vim'
	Plug 'thaerkh/vim-workspace'
	Plug 'kkoomen/vim-doge'
	Plug 'Yilin-Yang/vim-markbar'
	Plug 'tpope/vim-repeat'
	Plug 'svermeulen/vim-yoink'
	Plug 'svermeulen/vim-subversive'
	Plug 'othree/eregex.vim'
	Plug 'dhruvasagar/vim-table-mode'
	Plug 'psliwka/vim-smoothie'
	Plug 'junegunn/vim-peekaboo'
	Plug 'Chiel92/vim-autoformat'
	Plug 'chrisbra/Colorizer'
	Plug 'dylon/vim-antlr'
	Plug 'jreybert/vimagit'
	Plug 'Shirk/vim-gas'

	Plug 'vim-pandoc/vim-pandoc'
	Plug 'vim-pandoc/vim-pandoc-syntax'
	Plug 'iamcco/mathjax-support-for-mkdp'
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

	" Plug 'junegunn/vim-peekaboo'
	Plug 'neovim/nvim-lsp'
	Plug 'Shougo/neosnippet.vim'
	Plug 'Shougo/neosnippet-snippets'
	" Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
	Plug 'mustache/vim-mustache-handlebars'
	Plug 'tikhomirov/vim-glsl'
	" Plug 'tpope/vim-sleuth'
	Plug 'qpkorr/vim-bufkill'
	Plug 'sbdchd/neoformat'
	Plug 'inkarkat/vim-ingo-library'
	Plug 'inkarkat/vim-ArgsAndMore'
	Plug 'christoomey/vim-conflicted'
	Plug 'vim-scripts/DoxygenToolkit.vim'

	let lex_uses_cpp=1
	let yacc_uses_cpp=1
	Plug 'justinmk/vim-syntax-extra'
	Plug 'goldfeld/vim-seek'
	Plug 'mhinz/vim-signify'

	Plug 'arcticicestudio/nord-vim'

call plug#end()

set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme nord

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
	\ 'bg':      ['bg', 'Normal'],
	\ 'hl':      ['fg', 'Comment'],
	\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
	\ 'hl+':     ['fg', 'Statement'],
	\ 'info':    ['fg', 'PreProc'],
	\ 'border':  ['fg', 'Ignore'],
	\ 'prompt':  ['fg', 'Conditional'],
	\ 'pointer': ['fg', 'Exception'],
	\ 'marker':  ['fg', 'Keyword'],
	\ 'spinner': ['fg', 'Label'],
	\ 'header':  ['fg', 'Comment'] }

let g:vista#renderer#enable_icon = 1

let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_z = '%#__accent_bold#%{g:airline_symbols.linenr}%3l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__#:%3v'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#branch#format = 2

let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_completed_snippet = 1

set stl+=%{ConflictedVersion()}

set undodir=~/.cache/neovim/undodir
set undofile
set backup
set backupdir=~/.cache/neovim/backup
set writebackup
set backupcopy=yes
set concealcursor=n
set autoread

set updatetime=100

let g:workspace_autosave_untrailspaces = 0
let g:workspace_autosave = 0

let g:workspace_session_disable_on_args = 1

set tabstop=2
set shiftwidth=2
set noexpandtab
set mouse=ni
set notimeout

set completeopt=noinsert,menuone,noselect
set concealcursor=n
set showbreak=↲

set spellfile+=~/.config/nvim/spell/en.utf-8.add
set spellfile+=./oneoff.utf-8.add

" Required for operations modifying multiple buffers like rename.
set hidden
inoremap <expr><C-Space> pumvisible() ? "\<C-n>" : "\<C-g>u\<C-x>\<C-o>"
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"
inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<S-tab>"
inoremap <expr><CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:neosnippet_complete()
  if neosnippet#expandable_or_jumpable()
    return "\<Plug>(neosnippet_expand_or_jump)"
	elseif pumvisible()
    return "\<C-y>"
  else
    return "\<Tab>"
  endif
endfunction

imap <expr><TAB> <SID>neosnippet_complete()

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

nmap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

let g:airline_powerline_fonts = 1

augroup pandoc_syntax
	au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
	au	BufNewFile,BufFilePre,BufRead *.md call deoplete#custom#buffer_option('auto_complete', v:false)
	au BufNewFile,BufFilePre,BufRead *.md set textwidth=80
augroup END

augroup haskell_indentation
	au! FileType haskell set expandtab
augroup END

augroup assembly
	au! BufNewFile,BufFilePre,BufRead *.s set filetype=gas
augroup END

let g:pandoc#syntax#conceal#use = 1
let g:mkdp_refresh_slow = 1

" For non-existant folders
augroup vimrc-auto-mkdir
	autocmd!
	autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
	function! s:auto_mkdir(dir, force)
		if !isdirectory(a:dir) && (a:force || input("'" . a:dir . "' does not exist. Create? [y/N] ") =~? '^y\%[es]$')
			call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
		endif
	endfunction
augroup END

augroup advanced_lex_yacc
	au BufRead,BufNewFile *.ll set filetype=lex
	au BufRead,BufNewFile *.yy set filetype=yacc
augroup END

nmap s <Plug>(easymotion-overwin-f2)

map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

set showcmd

nmap <C-P> :Buffers<CR>
imap <C-P> <Nop>

" nnoremap <Down> gj
" nnoremap <Up> gk
" " inoremap <Down> <C-o>gj
" " inoremap <Up> <C-o>gk
" vnoremap <Down> gj
" vnoremap <Up> gk
" tnoremap <Esc> <C-\><C-n>

setlocal spell spelllang=en
set nospell

fun! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfun

command! TrimWhitespace call TrimWhitespace()

nmap <leader>e :Ag<CR>
nmap <leader>g :GFiles<CR>

func! WordProcessorMode()
	" Load Markdown syntax highlighting but with custom hashtag support
	" set filetype=mkd
	" syn match htmlBoldItalic "#[-_a-zA-Z0-9]\+"

	" Other options
	set nonumber
	set wrap
	set linebreak
	set breakat=\ 
	set display=lastline
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	" set formatoptions=
	set spell spelllang=en_gb
	" call deoplete#custom#option('auto_complete', v:false)

	" Auto-capitalize script
	augroup SENTENCES
		au!
		autocmd InsertCharPre * if search('\v(%^|[.!?]\_s+|\_^\-\s|\_^title\:\s|\n\n)%#', 'bcnw') != 0 | let v:char = toupper(v:char) | endif
	augroup END
endfu

com! WordProcessorMode call WordProcessorMode()

set showcmd

" Better display for messages
set cmdheight=2

" To search with PCRE, use ':M/'
let g:eregex_default_enable = 0
nnoremap <leader>/ :call eregex#toggle()<CR>

command! -nargs=0 ShowTrailingWhitespace /\s\+$

nnoremap <Leader>cf :ClangFormat<CR>
" vnoremap = :ClangFormat<CR>
set listchars=eol:$,tab:↣·,trail:~,extends:>,precedes:>

nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-s-n> <plug>(YoinkPostPasteSwapForward)
nmap <c-=> <plug>(YoinkPostPasteToggleFormat)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
xmap p <plug>(SubversiveSubstitute)
xmap P <plug>(SubversiveSubstitute)

nmap ,p "+p
nmap ,P "+P
xmap ,p "+p
xmap ,P "+P

" don't delay for leader
set ttimeout

" don't give |ins-completion-menu| messages.
set shortmess+=c

inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

nnoremap =p ]p

nnoremap <leader>t :TrimWhitespace<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
cnoremap w!! execute 'silent! write !SUDO_ASKPASS=`which ssh-askpass` sudo tee % >/dev/null' <bar> edit!

lua << EOF
local nvim_lsp = require 'nvim_lsp'
nvim_lsp.ccls.setup({})
nvim_lsp.hie.setup({})
EOF

autocmd Filetype c,cpp,haskell,go setl omnifunc=v:lua.vim.lsp.omnifunc
nnoremap <silent> ;dc <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ;df <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ;h  <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> ;i  <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> ;s  <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> ;td <cmd>lua vim.lsp.buf.type_definition()<CR>

" let g:doge_clang_args = [ '--std', 'c++17' ]
let g:doge_mapping_comment_jump_forward='<C-j>'

" Ignore stupid paging operations
nmap <S-Down> <Down>
nmap <S-Up> <Up>

nmap <S-A-Down> <Down>
nmap <S-A-Up> <Up>

let g:yoinkIncludeDeleteOperations=1
let g:yoinkSavePersistently=1
let g:yoinkMoveCursorToEndOfPaste=1

let g:yoinkSwapClampAtEnds=0
" Open vimagit pane
nnoremap <leader>gs :Magit<CR>       " git status
