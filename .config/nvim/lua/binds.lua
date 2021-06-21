vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap
-- local bufmap = vim.api.nvim_buf_set_keymap

-- Use <Tab> and <S-Tab> to navigate through popup menu
map('i', '<Tab>',   [[pumvisible() ? "\<C-n>-- : "\<Tab>"]], { noremap = true, expr = true })
map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>-- : "\<S-Tab>"]], { noremap = true, expr = true })

-- QOL rebinds
map('i', 'jk', '<esc>', {} )
map('i', 'kj', '<esc>', {} )
map('i', 'jj', '<C-o>', {} )
map('', 'C-s>', ':w<CR>', {} )

-- full buff text object
map('o', 'ib', [[:<c-u>normal! mzggVG<cr>`z]], { noremap = true } )

-- center search
map('n', 'n', 'nzzzv', { noremap = true })
map('n', 'N', 'Nzzzv', { noremap = true })

-- clibpord things
map('', 'YY', '"+yy', { noremap = true } )
map('', 'leader>p', '"+gP<CR>', { noremap = true } )
map('n', 'XX', '"+x<CR>', { noremap = true } )

-- Switching windows
map('', '<C-j>', [[<C-w>j]], { noremap = true } )
map('', '<C-k>', [[<C-w>k]], { noremap = true } )
map('', '<C-l>', [[<C-w>l]], { noremap = true } )
map('', '<C-h>', [[<C-w>h]], { noremap = true } )

-- useful visual mode things
map('v', '<', [[<gv]], {} )
map('v', '>', [[>gv]], {} )
map('v', 'J', [[:m '>+1<CR>gv=gv]], {} )
map('v', 'K', [[:m '<-2<CR>gv=gv]], {} )

-- spellcheck things
map('', '<M-s>', [[:setlocal spell! spelllang=en_us<CR>]], {} )
map('', '<M-S-s>', [[:setlocal spell! spelllang=es_es<CR>]], {} )
map('', '<M-t>', [[:Translate! ]], { noremap = true } )

-- goyo, removes visual noise
map('', '<Leader>z', [[:Goyo<CR>]], { silent = true } )
map('', '<leader>n', [[:call Mynum()<CR>]], { silent = true } )

-- nerd tree
map('', '<Leader>t', [[:NERDTreeToggle %:h<CR>]], { silent = true } )

-- undotree
map('', '<Leader>u', [[:UndotreeToggle<CR>]], { silent = true } )

-- wall
map('n', '<Leader><S-w>', [[:luafile ~/.config/nvim/pack/minpac/start/neowal/lua/neowal.lua<CR>]], { noremap = true } )

-- save on leader w
map('', '<Leader>w', [[:w<CR>]], { silent = true } )

-- Buffer list.
map('', '<Leader>b', [[:buffers<CR>]], { silent = true, noremap = true } )
map('', '<Leader>bb', [[:buffers<CR>]], { silent = true, noremap = true } )
map('', '<Leader>bn', [[:bnext<CR>]], { silent = true, noremap = true } )
map('', '<Leader>bp', [[:bprev<CR>]], { silent = true, noremap = true } )
map('', '<Leader>be', [[:bprev<CR>]], { silent = true, noremap = true } )

-- press tab for tabs
map('n', '<tab>', [[:tabnext<cr>]], { noremap = true } )
map('n', '<S-tab>', [[:tabprev<cr>]], { noremap = true } )

-- The following list was made with a macro that employed the following:
-- "let @z = char2nr(matchstr(getline('.'), '%'.col('.').'c.'))"
vim.cmd('digraph !! 161') -- ¡
vim.cmd('digraph ?? 191') -- ¿
vim.cmd('digraph +- 177') -- ±
vim.cmd('digraph dh 240') -- ð
vim.cmd('digraph dj 676') -- ʤ
vim.cmd('digraph gs 660') -- ʔ
vim.cmd('digraph ps 712') -- ˈ
vim.cmd('digraph ss 716') -- ˌ
vim.cmd('digraph rr 633') -- ɹ
vim.cmd('digraph sh 643') -- ʃ
vim.cmd('digraph ts 679') -- ʧ
vim.cmd('digraph uh 652') -- ʌ
vim.cmd('digraph zh 658') -- ʒ
vim.cmd('digraph th 952') -- θ

