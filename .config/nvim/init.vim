let mapleader = " "

call plug#begin()

" Plug 'jackguo380/vim-lsp-cxx-highlight', { 'highlight': { 'lsRanges' : v:true }, }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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

Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'vim-pandoc/vim-pandoc-syntax'

" Plug 'junegunn/vim-peekaboo'
Plug 'mustache/vim-mustache-handlebars'
Plug 'tikhomirov/vim-glsl'
" Plug 'tpope/vim-sleuth'
Plug 'qpkorr/vim-bufkill'
Plug 'sbdchd/neoformat'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-ArgsAndMore'

let lex_uses_cpp=1
let yacc_uses_cpp=1
Plug 'justinmk/vim-syntax-extra'
Plug 'goldfeld/vim-seek'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
Plug 'mhinz/vim-signify'

Plug 'arcticicestudio/nord-vim'

call plug#end()

set undodir=~/.cache/neovim/undodir
set undofile
set backup
set backupdir=~/.cache/neovim/backup
set writebackup
set backupcopy=yes

set updatetime=100

let g:workspace_autosave_untrailspaces = 0
let g:workspace_autosave = 0

let g:workspace_session_disable_on_args = 1

set completeopt=noinsert,menuone,noselect

" Required for operations modifying multiple buffers like rename.
set hidden
" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
inoremap <expr><C-Space> pumvisible() ? "\<C-n>" : "\<C-g>u\<C-x>\<C-o>"
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"
inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<S-tab>"
inoremap <expr><CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

set tabstop=4				" number of visual spaces per TAB
set shiftwidth=0		" number of spaces to use for autoindent
set noexpandtab

let g:airline_powerline_fonts = 1

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme nord

augroup pandoc_syntax
	au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
	au	BufNewFile,BufFilePre,BufRead *.md call deoplete#custom#buffer_option('auto_complete', v:false)
augroup END

augroup haskell_indentation
	au! FileType haskell set expandtab
augroup END

let g:pandoc#syntax#conceal#use = 1
let g:mkdp_refresh_slow = 1

set mouse=n
set showbreak=↲

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

fun! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfun

command! TrimWhitespace call TrimWhitespace()

nnoremap <C-i> i_<Esc>r

nmap s <Plug>(easymotion-overwin-f2)
map <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

map <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

set showcmd

nnoremap <Leader>b :Buffers<CR>
inoremap <C-P> <Nop>

nnoremap <Down> gj
nnoremap <Up> gk

vnoremap <Down> gj
vnoremap <Up> gk

vnoremap d "1d

setlocal spell spelllang=en

fun! FuzzyEdit(...)
	if a:0 > 0
		let path = get(a:, 1, 0)
		execute 'Files' path
	else
		Files %:p:h
	endif
endfun

command! -nargs=? FuzzyEdit call FuzzyEdit(<f-args>)

set nospell

nnoremap <Leader>e :FuzzyEdit<Space>
tnoremap <Esc> <C-\><C-n>

command! -nargs=0 ShowTrailingWhitespace /\s\+$

nnoremap <Leader>cf :ClangFormat<CR>
vnoremap = :ClangFormat<CR>
set listchars=eol:$,tab:↣·,trail:~,extends:>,precedes:>

nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <expr> <c-p> yoink#isSwapping() ? '<plug>(YoinkPostPasteSwapForward)' : ':Buffers<CR>'
nmap <c-=> <plug>(YoinkPostPasteToggleFormat)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
xmap p <plug>(SubversiveSubstitute)
xmap P <plug>(SubversiveSubstitute)

nmap ,p "+p
nmap ,P "+P
xmap ,p "+p
xmap ,P "+P

nmap <F5> <Plug>(coc-codeaction)

" don't delay for leader
set ttimeout

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use <c-space> to trigger completion.
inoremap <silent> <c-space> <c-n>

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

nnoremap <leader>e :GitFiles<CR>

let g:yoinkIncludeDeleteOperations=1
let g:yoinkSavePersistently=1
let g:yoinkMoveCursorToEndOfPaste=1
let g:yoinkSwapClampAtEnds=0
