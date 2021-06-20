" colorscheme theme things
lua require('colorbuddy').colorscheme('neowal')
colorscheme gruvbox
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
set undodir=~/.config/nvim/undo
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
