vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap
local cmd = vim.cmd
local g = vim.g
-- local bufmap = vim.api.nvim_buf_set_keyma

local opts = { silent = true, noremap = true }
local optsexpr = { silent = false, noremap = true, expr = true }
-- local optsexpr = { silent = true, noremap = true, expr = true }

-- map('', '<leader><S-w>',  [[:luafile ~/.local/share/nvim/site/pack/paqs/start/neowal/lua/neowal.lua<CR>]], opts )

map('', '<leader>w',      [[<C-w>]],                                                                       { noremap = true } )
map('', '-',              [[:e %:p:h<CR>]],                                                                opts )
map('', '<C-s>',          [[:w<CR>]],                                                                      opts )

map('', '<C-j>',          [[<C-w>j]],                                                                      opts )
map('', '<C-k>',          [[<C-w>k]],                                                                      opts )
map('', '<C-l>',          [[<C-w>l]],                                                                      opts )
map('', '<C-h>',          [[<C-w>h]],                                                                      opts )

map('', '<leader>tz',     [[:Goyo<CR>]],                                                                   opts )
map('', '<leader>tn',     [[:lua ToggleNums()<CR>]],                                                       opts )
map('', '<leader>tu',     [[:UndotreeToggle<CR>]],                                                         opts )

map('', '<leader>bb',     [[:buffers<CR>]],                                                                opts )
map('', '<leader>bn',     [[:bnext<CR>]],                                                                  opts )
map('', '<leader>bp',     [[:bprev<CR>]],                                                                  opts )
map('', '<leader>be',     [[:bprev<CR>]],                                                                  opts )

map('o', 'ib',            [[:<c-u>normal! mzggVG<cr>`z]],                                                  opts )

map('t', '<esc>',         [[<C-\><C-n>]],                                                                  opts )

map('v', '<',             [[<gv]],                                                                         opts )
map('v', '>',             [[>gv]],                                                                         opts )
map('v', 'J',             [[:m '>+1<CR>gv=gv]],                                                            opts )
map('v', 'K',             [[:m '<-2<CR>gv=gv]],                                                            opts )

map('v', '<S-y>',         [["+y]],                                                                         { noremap = true } )
map('v', '<leader>y',     [["+y]],                                                                         { noremap = true } )
map('n', '<leader>y',     [["+y]],                                                                         { noremap = true } )
map('n', '<leader>Y',     [[gg"+yG]],                                                                      { noremap = true } )

map('n', 'n',             [[nzzzv]],                                                                       opts )
map('n', 'N',             [[Nzzzv]],                                                                       opts )

map('n', '<M-s>',         [[:setlocal spell! spelllang=en_us<CR>]],                                        { noremap = true } )
map('n', '<M-S-s>',       [[:setlocal spell! spelllang=es_es<CR>]],                                        { noremap = true } )
map('n', '<M-t>',         [[:Translate! ]],                                                                { noremap = true } )
map('n', '<S-M-t>',       [[:Translate ]],                                                                 { noremap = true } )

map('n', '<leader>ff',    [[:lua require('telescope.builtin').find_files()<CR>]],                          opts )
map('n', '<leader>fg',    [[:lua require('telescope.builtin').live_grep()<CR>]],                           opts )
map('n', '<leader>fh',    [[:lua require('telescope.builtin').help_tags()<CR>]],                           opts )
map('n', '<leader>fc',    [[:lua require('telescope.builtin').find_files({ prompt_title = '[ config ]', cwd = '~/.dotfiles/dots-and-scripts/.config/' })<CR>]], opts)

map('i', 'jk',            [[<esc>]],                                                                       opts )
map('i', 'kj',            [[<esc>]],                                                                       opts )
map('i', 'jj',            [[<C-o>]],                                                                       opts )

map('i', '<c-y>', 'compe#confirm("<c-y>")', optsexpr )
map('i', '<CR>', 'compe#confirm("<CR>")', optsexpr )
map('i', '<c-e>', 'compe#close("<c-e>")', optsexpr )
map('i', '<c-space>', 'compe#complete()', optsexpr )

g.UltiSnipsExpandTrigger = '<C-f>'
g.UltiSnipsJumpForwardTrigger = '<C-tab>'
g.UltiSnipsJumpBackwardTrigger = '<C-S-tab>'

cmd[[
augroup tab_completition
    autocmd!
    "use <Tab> to go through list of completitions
    au VimEnter * inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    au VimEnter * inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
augroup END
]]

-- The following list was made with a macro that employed the following:
-- "let @z = char2nr(matchstr(getline('.'), '%'.col('.').'c.'))"
cmd('digraph !! 161') -- ¡
cmd('digraph ?? 191') -- ¿
cmd('digraph +- 177') -- ±
cmd('digraph dh 240') -- ð
cmd('digraph dj 676') -- ʤ
cmd('digraph gs 660') -- ʔ
cmd('digraph ps 712') -- ˈ
cmd('digraph ss 716') -- ˌ
cmd('digraph rr 633') -- ɹ
cmd('digraph sh 643') -- ʃ
cmd('digraph ts 679') -- ʧ
cmd('digraph uh 652') -- ʌ
cmd('digraph zh 658') -- ʒ
cmd('digraph th 952') -- θ
