let mapleader="\ "

" nnoremap <Leader>lc :lua vim.lsp.buf.code_action()<CR>"
" nnoremap <Leader>ld :lua vim.lsp.buf.definition()<CR>
" nnoremap <Leader>lf :lua vim.lsp.buf.formatting()<CR>"
" nnoremap <Leader>lh :lua vim.lsp.buf.hover()<CR>
" nnoremap <Leader>li :lua vim.lsp.buf.formatting()<CR>"
" nnoremap <Leader>li :lua vim.lsp.buf.implementation()<CR>
" nnoremap <Leader>ln :lua vim.lsp.buf.rename()<CR>
" nnoremap <Leader>lr :lua vim.lsp.buf.references()<CR>
" nnoremap <Leader>ls :lua vim.lsp.buf.signature_help()<CR>

" custom function for going to the middle of text objects, uses mark @z
" nnoremap <silent> gmp :call GoToMiddle("ip")<CR>
" nnoremap <silent> gms :call GoToMiddle("is")<CR>
" nnoremap <silent> gmm :call GoToMiddle("il")<CR>
" nnoremap <silent> <M-}> :call GoToMiddle("ip")<CR>
" nnoremap <silent> <M-)> :call GoToMiddle("is")<CR>

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" unbinding hjkl to get better at vim
" nmap h <nop>
" nmap l <nop>
" nmap j <nop>
" nmap k <nop>
" nmap <left> <nop>
" nmap <right> <nop>

" QOL rebinds
" nnoremap <Space> :
" vnoremap <Space> :
" nnoremap h <C-w>
" vnoremap h <C-w>
" imap <M-f> <esc>gqipgi
imap jk <esc>
imap kj <esc>
imap jj <C-o>
nnoremap n nzz
nnoremap N Nzz
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

" useful visual mode things
vmap < <gv
vmap > >gv
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
nnoremap <Leader><S-w> :luafile ~/.config/nvim/pack/minpac/start/neowal/lua/neowal.lua<CR>
" save on leader w
map <silent> <Leader>w :w<CR>

" Buffer list.
nnoremap <silent> <Leader>b :buffers<CR>
nnoremap <silent> <Leader>bb :buffers<CR>
nnoremap <silent> <Leader>bn :bnext<CR>
nnoremap <silent> <Leader>bp :bprev<CR>
nnoremap <silent> <Leader>be :bprev<CR>

" press tab for tabs
nnoremap <tab> :tabnext<cr>
nnoremap <S-tab> :tabprev<cr>

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

