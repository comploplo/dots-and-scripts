lua require 'init'

if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif
packadd minpac
call minpac#init()
" call minpac#add('ericjuma/wal.vim')
" call minpac#add('nvim-lua/diagnostic-nvim')
" call minpac#add('vim-pandoc/vim-pandoc-syntax')
" call minpac#add('kevinhwang91/rnvimr')
call minpac#add('Th3Whit3Wolf/spacebuddy')
call minpac#add('ericjuma/neowal')
call minpac#add('godlygeek/tabular')
call minpac#add('humanoid-colors/vim-humanoid-colorscheme')
call minpac#add('junegunn/goyo.vim')
call minpac#add('junegunn/limelight.vim')
call minpac#add('mattn/emmet-vim')
call minpac#add('mbbill/undotree')
call minpac#add('mg979/vim-visual-multi')
call minpac#add('morhetz/gruvbox')
call minpac#add('neovim/nvim-lspconfig')
call minpac#add('nvim-lua/completion-nvim')
call minpac#add('nvim-lua/plenary.nvim')
call minpac#add('nvim-lua/popup.nvim')
call minpac#add('nvim-treesitter/nvim-treesitter')
call minpac#add('preservim/nerdtree')
call minpac#add('rhysd/clever-f.vim')
call minpac#add('ryanoasis/vim-devicons')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('tjdevries/colorbuddy.nvim')
call minpac#add('tomtom/tcomment_vim')
call minpac#add('tpope/vim-markdown')
call minpac#add('tpope/vim-surround')
" for snippets
call minpac#add('honza/vim-snippets')
call minpac#add('shougo/deoplete.nvim') "for async
call minpac#add('shougo/neosnippet')
packloadall

augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

" fun! ThePrimeagen_LspHighlighter()
"     lua print("Testing")
"     lua package.loaded["my_lspconfig"] = nil
"     lua require("my_lspconfig")
" endfun
" com! SetLspVirtualText call ThePrimeagen_LspHighlighter()

" goyo settings
" bound to alt-z, removes extra ui elements and highlights only the selected
" paragraph
fun! s:goyo_enter()
    set noshowmode
    set noshowcmd
    Limelight
endfun
fun! s:goyo_leave()
    set showmode
    set showcmd
    Limelight!
endfun

" this is a mess
fun! g:PandocSmartExport()
  if expand('%:e') == 'md'
    write
    let l:pandoccall = 'pandoc ' . expand('%') . ' -o ' . expand('%:p:h') . '/' . expand('%:t:r') . '.pdf --template homework.tex'
    if expand('%:p:h:h:t') == '2020'
      let l:pandoccall = l:pandoccall . ' --metadata classname="Ling ' . expand('%:p:h:t') . '"'
    endif
    echo l:pandoccall
    echo system(l:pandoccall)
  else
    echo 'invalid file type'
  endif
endfun

fun! g:GoToMiddle(denotation)
    if a:denotation == "ip"
        execute "normal!wv" . a:denotation . "\"zy"
    else
        execute "normal!v" . a:denotation . "\"zy"
    endif
    let l:object = @z
    let l:middle = strlen(l:object) / 2
    execute "normal!" . l:middle . " "
endfun

fun! Mynum()
    set nu!
    set relativenumber!
endfun

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" colorscheme humanoid
lua require('colorbuddy').colorscheme('neowal')
colorscheme neowal
" colorscheme wal
" mods to wal in fork:
hi StatusLineNC ctermbg=0 ctermfg=8
hi StatusLine ctermbg=7 ctermfg=8
hi VertSplit ctermbg=8 ctermfg=8
nnoremap <leader>w :luafile ~/.config/nvim/pack/minpac/start/neowal/lua/neowal.lua<CR>

" tab settings
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" undotree
set noswapfile
set nobackup
set undodir="~/.config/nvim/undodir"
set undofile

"auto source .vimrc in file when 'vim .' in that file
set exrc

" search settings
set nohlsearch
set ignorecase
set smartcase
set incsearch

" keeps unsaved files open in background, allows for fast swap without save
set hidden

" set cc=80
" set wildmenu

set noshowmode
set cmdheight=2
set updatetime=50
set shortmess+=c

set noerrorbells
set autoindent
set completeopt=menuone,noinsert,noselect
set encoding=UTF-8
set inccommand=nosplit
set incsearch
set mouse=a
set nowrap
set scrolloff=8
set sidescrolloff=1
set tabpagemax=6
set termguicolors
filetype plugin indent on
syntax on

call matchadd('ColorColumn', '\%100v', 81)
hi ColorColumn ctermbg=gray guibg=gray

let mapleader=","

" vim go (polyglot) settings.
let g:go_auto_sameids = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_declarations = 1

" tpope markdown
let g:markdown_syntax_conceal = 0

" limelight lowlight highlight settings, used in goyo
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'

" use deoplete.
let g:deoplete#enable_at_startup = 1

" completion
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_insert_delay = 1
let g:diagnostic_show_sign = 0
let g:diagnostic_virtual_text_prefix = ' '
let g:space_before_virtual_text = 5
" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" let g:diagnostic_trimmed_virtual_text = '20'
" call sign_define("LspDiagnosticsErrorSign", {"text" : "E", "texthl" : "LspDiagnosticsError"})
" call sign_define("LspDiagnosticsWarningSign", {"text" : "W", "texthl" : "LspDiagnosticsWarning"})
" call sign_define("LspDiagnosticsInformationSign", {"text" : "I", "texthl" : "LspDiagnosticsInformation"})
" call sign_define("LspDiagnosticsHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})

" for emmet, used with html :)
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Avoid showing message extra message when using completion
" set shortmess+=c

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

autocmd BufEnter * lua require'completion'.on_attach()
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype md setlocal spell! spelllang=en_us<CR>

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <M-l>c :lua vim.lsp.buf.code_action()<CR>"
nnoremap <M-l>d :lua vim.lsp.buf.definition()<CR>
nnoremap <M-l>f :lua vim.lsp.buf.formatting()<CR>"
nnoremap <M-l>h :lua vim.lsp.buf.hover()<CR>
nnoremap <M-l>i :lua vim.lsp.buf.formatting()<CR>"
nnoremap <M-l>i :lua vim.lsp.buf.implementation()<CR>
nnoremap <M-l>n :lua vim.lsp.buf.rename()<CR>
nnoremap <M-l>r :lua vim.lsp.buf.references()<CR>
nnoremap <M-l>s :lua vim.lsp.buf.signature_help()<CR>

" for pandoc
map <M-b> :call g:PandocSmartExport()<CR>

" unbinding hjkl to get better at vim
nmap h <nop>
nmap l <nop>
" nmap j <nop>
" nmap k <nop>
nmap <left> <nop>
nmap <right> <nop>
" QOL
imap <M-f> <esc>gqipgi
imap jk <esc>
imap jj <C-o>
nnoremap n nzz
nnoremap N Nzz
nnoremap <Space> :
vnoremap <Space> :
nnoremap h <C-w>
vnoremap h <C-w>
map <silent> <M-n> :call Mynum()<CR>
map <C-s> :w<CR>

" custom function for going to the middle of text objects, uses mark @z
nnoremap <silent> gmp :call GoToMiddle("ip")<CR>
nnoremap <silent> gms :call GoToMiddle("is")<CR>
nnoremap <silent> gmm :call GoToMiddle("il")<CR>
nnoremap <silent> <M-}> :call GoToMiddle("ip")<CR>
nnoremap <silent> <M-)> :call GoToMiddle("is")<CR>

"full buff text object
onoremap ib :<c-u>normal! mzggVG<cr>`z

" goyo, removes visual noise
map <silent> <M-z> :Goyo<CR>

" spellcheck
map <M-s> :setlocal spell! spelllang=en_us<CR>
map <M-S-s> :setlocal spell! spelllang=es_es<CR>
map <leader>s :spellr<CR>

" nerd tree
map <M-t> :NERDTreeToggle<CR>

" undotree
map <M-u> :UndotreeToggle<CR>

" Config for neosnippet, for snippets
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'


augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

" augroup on_save
"     autocmd!
"     autocmd BufWritePre * :call TrimWhitespace()
" augroup END
