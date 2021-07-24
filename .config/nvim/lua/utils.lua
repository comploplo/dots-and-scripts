local cmd = vim.cmd
-- local g = vim.g
require('lspkind').init()
require('which-key').setup { }
-- require('lspsaga').init_lsp_saga()
require('nvim_comment').setup()
require('dap').defaults.fallback.terminal_win_cmd = '35vsplit new'

-- local textsubjects = require('binds').textsubjects
local textobjects = require('binds').textobjects
local playground = require('binds').playground

require('compe').setup {
  -- documentation = {
  --   border = "rounded",
  -- },
  source = {
    path      = true,
    spell     = {filetypes = {'markdown', 'tex'}},
    buffer    = true,
    calc      = true,
    nvim_lsp  = true,
    nvim_lua  = true,
    vsnip     = false,
    ultisnips = false,
    luasnip   = true,
  },
}

require('nvim-treesitter.configs').setup {
  highlight = { enable = true, },
  indent    = { enable = true, },
  incremental_selection = {
    enable = true,
  },
  -- textsubjects = textsubjects,
  textobjects = textobjects,
  playground = playground,
}

require('zen-mode').setup {
  window      = {
    backdrop  = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    width     = 0.6, -- width of the Zen window
    height    = 1, -- height of the Zen window
  },
  plugins     = {
    options   = {
      enabled = true,
      ruler   = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight  = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns  = { enabled = false }, -- disables git signs
    tmux      = { enabled = false }, -- disables the tmux statusline
    -- this will change the font size on kitty when in zen mode
    -- to make this work, you need to set the following kitty options:
    -- - allow_remote_control socket-only
    -- - listen_on unix:/tmp/kitty
    kitty     = {
      enabled = true,
      font    = "+4", -- font size increment
    },
  },
}

require'treesitter-context.config'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
}

require('gitsigns').setup {
  numhl                       = false,
  linehl                      = false,
  watch_index                 = {
    interval                  = 1000,
    follow_files              = true
  },
  current_line_blame          = false,
  current_line_blame_delay    = 1000,
  current_line_blame_position = 'eol',
  sign_priority               = 6,
  update_debounce             = 100,
  status_formatter            = nil, -- Use default
  word_diff                   = false,
  use_decoration_api          = true,
  use_internal_diff           = true,  -- If luajit is present
}

-- function _G.ToggleNums ()
--   vim.cmd([[set number! relativenumber!]])
--   require('gitsigns').signcolumn = not require('gitsigns').signcolumn
-- end

cmd([[
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
]])

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
-- _G.tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-n>"
--   elseif vim.fn['vsnip#available'](1) == 1 then
--     return t "<Plug>(vsnip-expand-or-jump)"
--   elseif check_back_space() then
--     return t "<Tab>"
--   else
--     return vim.fn['compe#complete']()
--   end
-- end

-- _G.s_tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-p>"
--   elseif vim.fn['vsnip#jumpable'](-1) == 1 then
--     return t "<Plug>(vsnip-jump-prev)"
--   else
--     -- If <S-Tab> is not working in your terminal, change it to <C-h>
--     return t "<S-Tab>"
--   end
-- end

function _G.ToggleNums ()
  cmd([[set number! relativenumber!]])
  -- cmd([[Gitsigns toggle_signs]])
end

function _G.Lsp_Info()
    local warnings = vim.lsp.diagnostic.get_count(0, "Warning")
    local errors = vim.lsp.diagnostic.get_count(0, "Error")
    local hints = vim.lsp.diagnostic.get_count(0, "Hint")
    return string.format("H %d W %d E %d", hints, warnings, errors)
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif require("luasnip").expand_or_jumpable() then
        return t "<cmd>lua require'luasnip'.jump(1)<Cr>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif require("luasnip").jumpable(-1) then
        return t "<cmd>lua require'luasnip'.jump(-1)<CR>"
    else
        return t "<S-Tab>"
    end
end

-- -- This makes dirvish replace netrw
-- cmd([[
-- command! -nargs=? -complete=dir Explore Dirvish <args>
-- command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
-- command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
-- ]])

-- require'colorizer'.setup {
--   '*',
--   {
--     rgb_fn   = true,
--     hsl_fn   = true,
--   },
-- }


