vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap
local cmd = vim.cmd
local g = vim.g
-- local bufmap = vim.api.nvim_buf_set_keymap

local opts = { silent = true, noremap = true }
local optsexpr = { silent = true, noremap = true, expr = true }

-- QOL rebinds
map('i', 'jk', '<esc>', {} )
map('i', 'kj', '<esc>', {} )
map('i', 'jj', '<C-o>', {} )
map('', 'C-s>', ':w<CR>', {} )

-- full buff text object
map('o', 'ib', [[:<c-u>normal! mzggVG<cr>`z]], opts )

-- center search
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)

-- Switching windows
map('', '<C-j>', [[<C-w>j]], opts )
map('', '<C-k>', [[<C-w>k]], opts )
map('', '<C-l>', [[<C-w>l]], opts )
map('', '<C-h>', [[<C-w>h]], opts )

-- useful visual mode things
map('v', '<', [[<gv]], opts )
map('v', '>', [[>gv]], opts )
map('v', 'J', [[:m '>+1<CR>gv=gv]], opts )
map('v', 'K', [[:m '<-2<CR>gv=gv]], opts )

-- spellcheck things
map('', '<M-s>', [[:setlocal spell! spelllang=en_us<CR>]], opts )
map('', '<M-S-s>', [[:setlocal spell! spelllang=es_es<CR>]], opts )
map('', '<M-t>', [[:Translate! ]], { noremap = true } )
map('', '<S-M-t>', [[:Translate ]], { noremap = true } )

-- goyo, removes visual noise
map('', '<leader>tz', [[:Goyo<CR>]], opts )
-- numbers
map('', '<leader>tn', [[:lua ToggleNums()<CR>]], opts )
-- undotree
map('', '<leader>tu', [[:UndotreeToggle<CR>]], opts )
-- -- ranger in vim, replacing nerdTree for now
-- map('n', '<leader>tr', ':RnvimrToggle<CR>', {noremap = true, silent = true})
-- -- -- nerd tree
-- map('', '<leader>tt', [[:NERDTreeToggle %:h<CR>]], { silent = true } )

-- wall
map('n', '<leader><S-w>', [[:luafile ~/.local/share/nvim/site/pack/paqs/start/neowal/lua/neowal.lua<CR>]], opts )

-- save on leader w
-- map('', '<leader>w', [[:w<CR>]], opts )
map('', '<C-s>', [[:w<CR>]], opts )

-- Buffer list.
-- map('', '<leader>b', [[:buffers<CR>]], opts )
-- map('', '<leader>bb', [[:buffers<CR>]], opts )
map('', '<leader>bn', [[:bnext<CR>]], opts )
map('', '<leader>bp', [[:bprev<CR>]], opts )
map('', '<leader>be', [[:bprev<CR>]], opts )

-- leader Ex for local explore
map('n', '<leader>ex', ':Ex<CR>', opts )

-- press tab for tabs
map('n', '<C-tab>', [[:tabnext<cr>]], opts )
map('n', '<C-S-tab>', [[:tabprev<cr>]], opts )

-- " Using lua functions
-- nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
map('n', '<leader>ff', [[:lua require('telescope.builtin').find_files()<CR>]], opts)
-- nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
map('n', '<leader>fg', [[:lua require('telescope.builtin').live_grep()<CR>]], opts)
-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
map('n', '<leader>bb', [[:lua require('telescope.builtin').buffers()<CR>]], opts)
-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
map('n', '<leader>fh', [[:lua require('telescope.builtin').help_tags()<CR>]], opts)
map('n', '<leader>fc', [[:lua require('telescope.builtin').find_files({ prompt_title = '[ config ]', cwd = '~/.dotfiles/dots-and-scripts/.config/' })<CR>]], opts)

-- nnoremap <leader>y "+y
map('n', '<leader>y', [["+y]], { noremap = true })
-- vnoremap <leader>y "+y
map('v', '<leader>y', [["+y]], { noremap = true })
map('v', '<S-y>', [["+y]], { noremap = true })
-- nnoremap <leader>Y gg"+yG
map('n', '<leader>Y', [[gg"+yG]], { noremap = true })



-- Use <Tab> and <S-Tab> to navigate through popup menu
-- inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
map('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], optsexpr)
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], optsexpr)
-- map('', '', [[]], {})

-- -- Use <Tab> and <S-Tab> to navigate through popup menu
-- map('i', '<Tab>',   [[pumvisible() ? "<C-n>" : "<Tab>"]], { noremap = true, expr = true })
-- map('i', '<S-Tab>', [[pumvisible() ? "<C-p>" : "<S-Tab>"]], { noremap = true, expr = true })
g.UltiSnipsExpandTrigger = '<C-l>'
g.UltiSnipsJumpForwardTrigger = '<tab>'
g.UltiSnipsJumpBackwardTrigger = '<s-tab>'

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
