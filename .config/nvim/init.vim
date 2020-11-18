let mapleader=","

if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif
packadd minpac
call minpac#init()
" call minpac#add('ericjuma/wal.vim')
" call minpac#add('nvim-lua/diagnostic-nvim')
"call minpac#add('ericjuma/neowal')
call minpac#add('Th3Whit3Wolf/spacebuddy')
call minpac#add('ap/vim-css-color')
call minpac#add('godlygeek/tabular')
call minpac#add('hrsh7th/vim-vsnip')
call minpac#add('hrsh7th/vim-vsnip-integ')
call minpac#add('junegunn/goyo.vim')
call minpac#add('junegunn/limelight.vim')
call minpac#add('kevinhwang91/rnvimr')
call minpac#add('neovim/nvim-lspconfig')
call minpac#add('nvim-lua/completion-nvim')
call minpac#add('nvim-lua/plenary.nvim')
call minpac#add('nvim-lua/popup.nvim')
call minpac#add('plasticboy/vim-markdown')
call minpac#add('rhysd/clever-f.vim')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('tjdevries/colorbuddy.nvim')
call minpac#add('tomtom/tcomment_vim')
call minpac#add('tpope/vim-surround')
call minpac#add('vim-pandoc/vim-pandoc-syntax')

packloadall
set termguicolors
"lua require('colorbuddy').colorscheme('neowal')

" colorscheme wal
" mods to wal in fork:
" hi StatusLineNC ctermbg=0 ctermfg=8
" hi StatusLine ctermbg=7 ctermfg=8
" hi VertSplit ctermbg=8 ctermfg=8

" set wildmenu
set autoindent
set expandtab
set inccommand=nosplit
set incsearch
set mouse=a
set nowrap
set scrolloff=4
set shiftwidth=4
set sidescrolloff=1
set smartcase
set smartindent
set tabstop=4 softtabstop=4
set termguicolors
filetype plugin indent on
syntax on

nnoremap <Space> :
vnoremap <Space> :
" nnoremap h <c-w>
" vnoremap h <c-w>

augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
augroup END

" lsp
" I did pip install 'python-language-server[all]'
" LspInstall html
" LspInstall jdtls
" " LspInstall pyls -- not implemented
" LspInstall tsserver
" LspInstall vimls
" LspInstall texlab
" " LspInstall ghcide -- TODO install
" " LspInstall clangd TODO
" LspInstall bashls
" LspInstall vimls
"
lua << EOF

local on_attach_vim = function(client)
    require'completion'.on_attach(client)
end
require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.html.setup{
    on_attach=on_attach_vim,
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true
        }
    }
}
require'lspconfig'.html.setup{ on_attach=on_attach_vim }
require'lspconfig'.texlab.setup{ on_attach=on_attach_vim }
require'lspconfig'.bashls.setup{ on_attach=on_attach_vim }
require'lspconfig'.vimls.setup{ on_attach=on_attach_vim }
require'lspconfig'.jdtls.setup{ on_attach=on_attach_vim }
require'lspconfig'.sumneko_lua.setup{ 
    on_attach=on_attach_vim,
    cmd = { "/home/gabe/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/bin/Linux/lua-language-server", "-E", "/home/me/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua" },
}
require'lspconfig'.jsonls.setup{ on_attach=on_attach_vim }

EOF

" --- vim go (polyglot) settings.
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

" --- markdown
let g:vim_markdown_folding_disabled = 1

" --- snippets
let g:completion_enable_snippet = 'vim-vsnip'
let g:vsnip_snippet_dir = expand('~/.config/nvim/vsnip')

" limelight lowlight highlight settings, used in goyo
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'

fun! ThePrimeagen_LspHighlighter()
    lua print("Testing")
    lua package.loaded["my_lspconfig"] = nil
    lua require("my_lspconfig")
endfun

com! SetLspVirtualText call ThePrimeagen_LspHighlighter()

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END
" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ' '
" let g:diagnostic_trimmed_virtual_text = '20'
let g:space_before_virtual_text = 5
let g:diagnostic_show_sign = 0
" call sign_define("LspDiagnosticsErrorSign", {"text" : "E", "texthl" : "LspDiagnosticsError"})
" call sign_define("LspDiagnosticsWarningSign", {"text" : "W", "texthl" : "LspDiagnosticsWarning"})
" call sign_define("LspDiagnosticsInformationSign", {"text" : "I", "texthl" : "LspDiagnosticsInformation"})
" call sign_define("LspDiagnosticsHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})
let g:diagnostic_insert_delay = 1

set completeopt-=preview
" autocmd BufEnter * lua require'completion'.on_attach()
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
" set shortmess+=c
"

" --- markdown highlight
" autocmd filetype markdown syn region match start=/\\$\\$/ end=/\\$\\$/
" autocmd filetype markdown syn match math '\\$[^$].\{-}\$'

nnoremap <M-l>d :lua vim.lsp.buf.definition()<CR>
nnoremap <M-l>i :lua vim.lsp.buf.implementation()<CR>
nnoremap <M-l>s :lua vim.lsp.buf.signature_help()<CR>
nnoremap <M-l>r :lua vim.lsp.buf.references()<CR>
nnoremap <M-l>n :lua vim.lsp.buf.rename()<CR>
nnoremap <M-l>h :lua vim.lsp.buf.hover()<CR>
nnoremap <M-l>c :lua vim.lsp.buf.code_action()<CR>"
nnoremap <M-l>f :lua vim.lsp.buf.formatting()<CR>"
nnoremap <M-l>i :lua vim.lsp.buf.formatting()<CR>"
" nnoremap <Return>w :luafile ~/.config/nvim/pack/minpac/start/neowal/lua/neowal.lua<CR>

" " --- rnvimr, ranger in nvimnnoremap <Return>e  :lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>
" nnoremap <Return>g  :lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({}))<cr>
" nnoremap <Return>r  :lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_dropdown({}))<cr>
" nnoremap <Return><Space>  :lua require'telescope.builtin'.command_history(require('telescope.themes').get_dropdown({}))<cr>
" nnoremap <Return><Tab>  :lua require'telescope.builtin'.commands(require('telescope.themes').get_dropdown({}))<cr>
" nnoremap <Return>f  :lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({}))<cr>
" nnoremap <Return>lr :lua require'telescope.builtin'.lsp_references(require('telescope.themes').get_dropdown({}))<cr>
" nnoremap <Return>ls :lua require'telescope.builtin'.lsp_document_symbols(require('telescope.themes').get_dropdown({}))<cr>
" nnoremap <Return>t  :lua require'telescope.builtin'.treesitter(require('telescope.themes').get_dropdown({}))<cr>
" nnoremap <Return>lw :lua require'telescope.builtin'.lsp_workspace_symbols(require('telescope.themes').get_dropdown({}))<cr>
" nnoremap <Return>h :lua require'telescope.builtin'.help_tags{}<cr>

" 

" goyo settings
function! s:goyo_enter()
    set noshowmode
    set noshowcmd
    Limelight
endfunction

function! s:goyo_leave()
    set showmode
    set showcmd
    Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave() 

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

" for pandoc
map <M-b> :call g:PandocSmartExport()<CR>

" QOL
imap <M-q> <esc>gqipgi
imap jj <esc>
nnoremap n nzz
nnoremap N Nzz
nnoremap <silent> i :nohlsearch<cr>i
nnoremap <silent> a :nohlsearch<cr>a

" snippet expand
imap <expr> <M-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<M-j>'
smap <expr> <M-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<M-j>'

" goyo, removes visual noise
map <silent> <M-z> :Goyo<CR>

" rnvimr, ranger in vim
tnoremap <silent> <M-e> <C-\><C-n>:RnvimrResize<CR>
nnoremap <silent> <M-r> :RnvimrToggle<CR>
tnoremap <silent> <M-r> <C-\><C-n>:RnvimrToggle<CR>
" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1
" Disable a border for floating window
" let g:rnvimr_draw_border = 0

map <M-s> :setlocal spell! spelllang=en_us<CR>
map <M-S-s> :setlocal spell! spelllang=es_es<CR>
map <leader>s :spellr<CR>
