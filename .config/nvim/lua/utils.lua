local cmd = vim.cmd
-- local in_gui = not (vim.fn.environ().TERM == 'linux')
local actions = require("lir.actions")
-- local mark_actions = require('lir.mark.actions')
-- local clipboard_actions = require'lir.clipboard.actions'

-- local textsubjects = require('binds').textsubjects
local textobjects = require("binds").textobjects
local playground = require("binds").playground
local cmp_binds = require("binds").cmp_binds

-- local g = vim.g
-- require('lspsaga').init_lsp_saga()
require("dap").defaults.fallback.terminal_win_cmd = "35vsplit new"
require("luasnip/loaders/from_vscode").load()
require("nvim_comment").setup()
-- require('refactoring').setup()
require("treesitter-context.config").setup()
-- require('spellsitter').setup()

-- Setup nvim-cmp.
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp_binds,
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" }, -- For luasnip users.
    { name = "nvim_lua" },
    { name = "spell" },
    { name = "path" },
    { name = "latex_symbols", keyword_length = 3 },
    { name = "buffer", keyword_length = 5 },
    { name = "emoji", keyword_length = 5 },
  }),
  -- str8 copied from tj's config thanks tj
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      -- copied from cmp-under, but I don't think I need the plugin for this.
      -- I might add some more of my own.
      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find("^_+")
        local _, entry2_under = entry2.completion_item.label:find("^_+")
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  completion = {
    autocomplete = false,
  },
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  completion = {
    autocomplete = false,
  },
  sources = cmp.config.sources({
    {
      name = "path",
    },
  }, {
    {
      name = "cmdline",
      max_item_count = 20,
      keyword_length = 4,
    },
  }),
})

require('formatter').setup({
  filetype = {
    terraform = {
      function()
        return {
          exe = "terraform",
          args = { "fmt", "-" },
          stdin = true
        }
      end
    },
    python = {
      -- Configuration for psf/black
      function()
        return {
          exe = "black", -- this should be available on your $PATH
          args = { '-' },
          stdin = true,
        }
      end
    },
    lua = {
      function()
        return {
          exe = "stylua",
          args = {
            "--config-path "
              .. os.getenv("XDG_CONFIG_HOME")
              .. "/stylua/stylua.toml",
            "-",
          },
          stdin = true,
        }
      end,
    },
    sh = {
        -- Shell Script Formatter
       function()
         return {
           exe = "shfmt",
           args = { "-i", 2 },
           stdin = true,
         }
       end,
   },
   javascript = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
          stdin = true
        }
      end
    },
  }
})

require('nvim-biscuits').setup({
  default_config = {
    max_length = 12,
    min_distance = 5,
    prefix_string = " 📎 "
  },
  language_config = {
    html = {
      prefix_string = " 🌐 "
    },
    javascript = {
      prefix_string = " ✨ ",
      max_length = 80
    },
    python = {
      disabled = true
    }
  }
})

require("which-key").setup({
  plugins = {
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
  },
})

require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
  -- textsubjects = textsubjects,
  textobjects = textobjects,
  playground = playground,
})

require("zen-mode").setup({
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    width = 0.6, -- width of the Zen window
    height = 1, -- height of the Zen window
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
    -- this will change the font size on kitty when in zen mode
    -- to make this work, you need to set the following kitty options:
    -- - allow_remote_control socket-only
    -- - listen_on unix:/tmp/kitty
    kitty = {
      enabled = true,
      font = "+4", -- font size increment
    },
  },
})

require("gitsigns").setup({
  numhl = false,
  linehl = false,
  watch_index = {
    interval = 1000,
    follow_files = true,
  },
  current_line_blame = false,
  current_line_blame_opts = {
    delay = 1000,
    virt_text_pos = "eol",
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  word_diff = false,
  diff_opts = { internal = true }, -- If luajit is present
})

require("nvim-web-devicons").setup({ -- custom folder icon
  override = {
    lir_folder_icon = {
      icon = "",
      color = "#7ebae4",
      name = "LirFolderNode",
    },
  },
})

require("lir").setup({
  show_hidden_files = false,
  devicons_enable = true,
  mappings = {
    ["l"] = actions.edit,
    ["<CR>"] = actions.edit,
    ["<C-s>"] = actions.split,
    ["<C-v>"] = actions.vsplit,
    ["<C-t>"] = actions.tabedit,
    ["h"] = actions.up,
    ["-"] = actions.up,
    ["q"] = actions.quit,
    ["<ESC>"] = actions.quit,
    ["K"] = actions.mkdir,
    ["N"] = actions.newfile,
    ["R"] = actions.rename,
    -- ['@']     = actions.cd,
    ["Y"] = actions.yank_path,
    ["."] = actions.toggle_show_hidden,
    ["z"] = actions.toggle_show_hidden,
    -- ['D']     = actions.delete,
    -- ['J'] = function()
    --   mark_actions.toggle_mark()
    --   vim.cmd('normal! j')
    -- end,
    -- ['C'] = clipboard_actions.copy,
    -- ['X'] = clipboard_actions.cut,
    -- ['P'] = clipboard_actions.paste,
  },
  float = {
    winblend = 0,
  },
  hide_cursor = false,
})

require("lir.git_status").setup({
  show_ignored = false,
})

function _G.ToggleNums()
  cmd([[set number! relativenumber!]])
end

function _G.Lsp_Info()
  local warnings = vim.lsp.diagnostic.get_count(0, "Warning")
  local errors = vim.lsp.diagnostic.get_count(0, "Error")
  local hints = vim.lsp.diagnostic.get_count(0, "Hint")
  return string.format("H %d W %d E %d", hints, warnings, errors)
end

function _G.P(v)
  print(vim.inspect(v))
  return v
end

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
endif
echo 'invalid file type'
endfun
]])
