vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap
-- local bufmap = vim.api.nvim_buf_set_keymap

-- Use <Tab> and <S-Tab> to navigate through popup menu
-- map('i', '<Tab>',   [[pumvisible() ? "<C-n>-- : "<Tab>"]], { noremap = true, expr = true })
-- map('i', '<S-Tab>', [[pumvisible() ? "<C-p>-- : "<S-Tab>"]], { noremap = true, expr = true })

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
map('', '<Leader>tz', [[:Goyo<CR>]], { silent = true } )
-- numbers
map('', '<leader>tn', [[:lua ToggleNums()<CR>]], { silent = true } )
-- undotree
map('', '<Leader>tu', [[:UndotreeToggle<CR>]], { silent = true } )
-- -- ranger in vim, replacing nerdTree for now
-- map('n', '<Leader>tr', ':RnvimrToggle<CR>', {noremap = true, silent = true})
-- -- -- nerd tree
-- map('', '<Leader>tt', [[:NERDTreeToggle %:h<CR>]], { silent = true } )

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

-- leader Ex for local explore
map('n', '<Leader>ex', '', {})

-- press tab for tabs
map('n', '<tab>', [[:tabnext<cr>]], { noremap = true, silent = true } )
map('n', '<S-tab>', [[:tabprev<cr>]], { noremap = true } )

-- " Using lua functions
-- nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
map('n', '<leader>ff', [[:lua require('telescope.builtin').find_files()<CR>]], { noremap = true })
-- nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
map('n', '<leader>fg', [[:lua require('telescope.builtin').live_grep()<CR>]], { noremap = true })
-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
map('n', '<leader>fb', [[:lua require('telescope.builtin').buffers()<CR>]], { noremap = true })
-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
map('n', '<leader>fh', [[:lua require('telescope.builtin').help_tags()<CR>]], { noremap = true })
map('n', '<leader>fc', [[:lua require('telescope.builtin').find_files({ prompt_title = '[ config ]', cwd = '~/.dotfiles/dots-and-scripts/.config/' })<CR>]], { noremap = true, silent = true })
-- map('', '', [[]], {})

-- nnoremap <leader>y "+y
map('n', '<leader>y', [["+y]], { noremap = true })
-- vnoremap <leader>y "+y
map('v', '<leader>y', [["+y]], { noremap = true })
-- nnoremap <leader>Y gg"+yG
map('n', '<leader>Y', [[gg"+yG]], { noremap = true })
-- map('', '', [[]], {})



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

