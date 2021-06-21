" init lua modules, currently treesitter and lsps
lua require 'init'

" packages
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif
packadd minpac
call minpac#init()
" call minpac#add('ericjuma/wal.vim')
" call minpac#add('nvim-lua/diagnostic-nvim')
call minpac#add('vim-pandoc/vim-pandoc-syntax')
" call minpac#add('kevinhwang91/rnvimr')
call minpac#add('Th3Whit3Wolf/spacebuddy')
call minpac#add('ericjuma/neowal')
call minpac#add('godlygeek/tabular')
call minpac#add('humanoid-colors/vim-humanoid-colorscheme')
call minpac#add('junegunn/goyo.vim')
call minpac#add('junegunn/limelight.vim')
call minpac#add('kana/vim-textobj-user') " required by vim-textobj-space
" call minpac#add('kovetskiy/sxhkd-vim')
call minpac#add('kyazdani42/nvim-web-devicons')
call minpac#add('liuchengxu/vista.vim')
call minpac#add('mattn/emmet-vim')
call minpac#add('mbbill/undotree')
call minpac#add('morhetz/gruvbox')
call minpac#add('neovim/nvim-lspconfig')
call minpac#add('nvim-lua/completion-nvim')
call minpac#add('nvim-lua/plenary.nvim')
call minpac#add('nvim-lua/popup.nvim')
call minpac#add('nvim-treesitter/nvim-treesitter')
call minpac#add('preservim/nerdtree')
call minpac#add('rhysd/clever-f.vim')
call minpac#add('ryanoasis/vim-devicons')
call minpac#add('saihoooooooo/vim-textobj-space')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('tjdevries/colorbuddy.nvim')
call minpac#add('tomtom/tcomment_vim')
call minpac#add('tpope/vim-markdown')
call minpac#add('tpope/vim-surround')
" for translating words from en to es
call minpac#add('skanehira/translate.vim')
packloadall

" goyo settings
" bound to leader z, removes extra ui elements and highlights only the selected
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

fun! g:PandocSmartExport()
  if expand('%:e') == 'md'
    write
    if 'Ling' =~ expand('%:p:h:t')
        let l:pandoccall = 'pandoc ' . expand('%') . ' -o ' . expand('%:p:h') . '/' . expand('%:t:r') . '.pdf --template homework-ling.tex'
    else 
        let l:pandoccall = 'pandoc ' . expand('%') . ' -o ' . expand('%:p:h') . '/' . expand('%:t:r') . '.pdf --template homework.tex --pdf-engine xelatex'
    endif
    echo l:pandoccall
    echo system(l:pandoccall)
  else
    echo 'invalid file type'
  endif
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

" fun! g:GoToMiddle(denotation)
"     if a:denotation == "ip"
"         execute "normal!wv" . a:denotation . "\"zy"
"     else
"         execute "normal!v" . a:denotation . "\"zy"
"     endif
"     let l:object = @z
"     let l:middle = strlen(l:object) / 2
"     execute "normal!" . l:middle . " "
" endfun


" augroups and autocmds for QOL
augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

" augroup oen_save
"     autocmd!
"     autocmd beufWritePr * :call TrimWhitespace()
" augroup END

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" autocommands for qol in markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd FileType markdown set conceallevel=2
autocmd FileType markdown setlocal spell spelllang=en_us
autocmd FileType markdown map <M-b> :call g:PandocSmartExport()<CR>
autocmd FileType markdown nmap <Leader>c :call g:PandocSmartExport()<CR>
" spanish translation
autocmd FileType markdown nmap gr <Plug>(Translate)
autocmd FileType markdown vmap T <Plug>(VTranslate)
autocmd FileType markdown nmap <leader>t :Translate! 
autocmd FileType markdown nmap <leader>T :Translate 
autocmd FileType text nmap <leader>t :Translate! 
autocmd FileType text nmap <leader>T :Translate 
" emmet makes writing html easier
autocmd FileType html,css EmmetInstall

" colorscheme theme things
lua require('colorbuddy').colorscheme('neowal')
colorscheme desert
" colorscheme default
" " mods to wal in fork:
" hi StatusLineNC ctermbg=0 ctermfg=8
" hi StatusLine ctermbg=7 ctermfg=8
" hi VertSplit ctermbg=8 ctermfg=8
" hi NonText ctermfg=0
" hi htmlH2 ctermbg=0 ctermfg=7
" hi htmlH3 ctermbg=0 ctermfg=7
" hi Title ctermbg=0 ctermfg=7
" hi TabLine ctermbg=0 ctermfg=7
" hi TabLineSel ctermbg=0 ctermfg=7
" hi TabLineFill ctermbg=0 ctermfg=7

" highlights the 80th character of the line if it exists
" call matchadd('ColorColumn', '\%100v', 81)
" hi ColorColumn ctermbg=gray guibg=gray

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
" set digraph

set autoindent
set cmdheight=2
set completeopt=menu,menuone,noselect
set digraph
set encoding=UTF-8
set inccommand=nosplit
set incsearch
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<
set mouse=a
set noerrorbells
set noshowmode
set nowrap
set scrolloff=8
set shortmess+=c
set sidescrolloff=1
set tabpagemax=6
set termguicolors
set updatetime=50
filetype plugin indent on
syntax on

let mapleader=","

" tpope markdown
let g:markdown_syntax_conceal = 0
let g:folding = 0

" limelight lowlight highlight settings, used in goyo
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'

" completion
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_insert_delay = 1
let g:diagnostic_show_sign = 0
let g:diagnostic_virtual_text_prefix = ' '
let g:space_before_virtual_text = 5
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:diagnostic_trimmed_virtual_text = '20'
call sign_define("LspDiagnosticsErrorSign", {"text" : "E", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "W", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "I", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})

" translate from english to spanish
let g:translate_source = "en"
let g:translate_target = "es"
let g:translate_popup_window = 0 " if you want use popup window, set value 1
let g:translate_winsize = 1 " set buffer window height size if you doesn't use popup window

let g:user_emmet_install_global = 0

"The following list was made with a macro that employed the following:
" "let @z = char2nr(matchstr(getline('.'), '%'.col('.').'c.'))"
digraph !! 161 "¡
digraph ?? 191 "¿
digraph +- 177 "±
digraph dh 240 "ð
digraph dj 676 "ʤ
digraph gs 660 "ʔ
digraph ps 712 "ˈ
digraph ss 716 "ˌ
digraph rr 633 "ɹ
digraph sh 643 "ʃ
digraph ts 679 "ʧ
digraph uh 652 "ʌ
digraph zh 658 "ʒ
digraph th 952 "θ

" LSP THINGS
" Avoid showing message extra message when using completion
" set shortmess+=c

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <Leader>lc :lua vim.lsp.buf.code_action()<CR>"
nnoremap <Leader>ld :lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>lf :lua vim.lsp.buf.formatting()<CR>"
nnoremap <Leader>lh :lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>li :lua vim.lsp.buf.formatting()<CR>"
nnoremap <Leader>li :lua vim.lsp.buf.implementation()<CR>
nnoremap <Leader>ln :lua vim.lsp.buf.rename()<CR>
nnoremap <Leader>lr :lua vim.lsp.buf.references()<CR>
nnoremap <Leader>ls :lua vim.lsp.buf.signature_help()<CR>

" custom function for going to the middle of text objects, uses mark @z
" nnoremap <silent> gmp :call GoToMiddle("ip")<CR>
" nnoremap <silent> gms :call GoToMiddle("is")<CR>
" nnoremap <silent> gmm :call GoToMiddle("il")<CR>
" nnoremap <silent> <M-}> :call GoToMiddle("ip")<CR>
" nnoremap <silent> <M-)> :call GoToMiddle("is")<CR>

" git gud debinds
" unbinding hjkl to get better at vim
" nmap h <nop>
" nmap l <nop>
" nmap j <nop>
" nmap k <nop>
nmap <left> <nop>
nmap <right> <nop>

" QOL rebinds
" imap <M-f> <esc>gqipgi
imap jk <esc>
imap hj <esc>
imap kk <C-o>
nnoremap n nzz
nnoremap N Nzz
" nnoremap <Space> :
" vnoremap <Space> :
" nnoremap h <C-w>
" vnoremap h <C-w>
map <C-s> :w<CR>
"full buff text object
onoremap ib :<c-u>normal! mzggVG<cr>`z
" center search
nnoremap n nzzzv
nnoremap N Nzzzv
" clibpord things
noremap YY "+yy
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>
" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv
" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" spellcheck things
map <M-s> :setlocal spell! spelllang=en_us<CR>
map <M-S-s> :setlocal spell! spelllang=es_es<CR>
map <M-t> :Translate! 
" goyo, removes visual noise
map <silent> <Leader>z :Goyo<CR>
map <silent> <leader>n :call Mynum()<CR>
" nerd tree
map <silent> <Leader>t :NERDTreeToggle %:h<CR>
" undotree
map <silent> <Leader>u :UndotreeToggle<CR>
" wall
nnoremap <Leader>w :luafile ~/.config/nvim/pack/minpac/start/neowal/lua/neowal.lua<CR>
" Buffer list.
nnoremap <silent> <Leader>b :buffers<CR>
nnoremap <silent> <Leader>bb :buffers<CR>
nnoremap <silent> <Leader>bn :bnext<CR>
nnoremap <silent> <Leader>bp :bprev<CR>
nnoremap <silent> <Leader>be :bprev<CR>

nnoremap <tab> :tabnext<cr>
nnoremap <S-tab> :tabprev<cr>
