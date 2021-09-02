local cmd = vim.cmd
local in_gui = not (vim.fn.environ().TERM == 'linux')
<<<<<<< HEAD
local actions = require('lir.actions')
-- local mark_actions = require('lir.mark.actions')
-- local clipboard_actions = require'lir.clipboard.actions'

-- local textsubjects = require('binds').textsubjects
local textobjects = require('binds').textobjects
local playground = require('binds').playground
local cmp_binds = require('binds').cmp_binds

local cmp_formatting = {}
if in_gui then
  cmp_formatting =
    { format = function(entry, vim_item)
      vim_item.kind = require('lspkind').presets.default[vim_item.kind]
      vim_item.menu = ({
        spell = '',
        buffer = '',
        calc = '',
        emoji = '',
        path = '/',
        latex_symbols = 'λ',
        luasnip = '',
        nvim_lua = '',
        nvim_lsp = '',
      })[entry.source.name]
      return vim_item
    end,
    }
else --in tty
  cmp_formatting = { format = function(entry, vim_item)
    -- fancy icons and a name of kind
    -- vim_item.kind = require('lspkind').presets.default[vim_item.kind]
    -- .. ' '
    -- .. vim_item.kind
    -- set a name for each source
    vim_item.menu = ({
      spell = '[Sp]',
      buffer = '[Bu]',
      calc = '[Ca]',
      emoji = '[Em]',
      path = '[Pa]',
      latex_symbols = '[La]',
      luasnip = '[Sn]',
      nvim_lua = '[Lu]',
      nvim_lsp = '[Ls]',
    })[entry.source.name]
    return vim_item
  end,
  }
end

-- local g = vim.g
-- require('lspsaga').init_lsp_saga()
require('dap').defaults.fallback.terminal_win_cmd = '35vsplit new'
require('luasnip/loaders/from_vscode').load()
require('nvim_comment').setup()
require('refactoring').setup()
require('treesitter-context.config').setup()
require('spellsitter').setup()

require('which-key').setup({
  plugins = {
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    }
  }
})

require('cmp').setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  mapping = cmp_binds,

  sources = {
    { name = 'spell' },
    { name = 'buffer' },
    { name = 'calc' },
    { name = 'emoji' },
    { name = 'path' },
    { name = 'latex_symbols' },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'tmux' },
  },

  formatting = cmp_formatting,
})

require('nvim-treesitter.configs').setup({
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
  },
  -- textsubjects = textsubjects,
  textobjects = textobjects,
  playground = playground,
})

require('zen-mode').setup({
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
      font = '+4', -- font size increment
    },
  },
})

require('gitsigns').setup({
  numhl = false,
  linehl = false,
  watch_index = {
    interval = 1000,
    follow_files = true,
  },
  current_line_blame = false,
  current_line_blame_opts = {
    delay = 1000,
    virt_text_pos = 'eol',
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  word_diff = false,
  use_internal_diff = true, -- If luajit is present
})

require('nvim-web-devicons').setup({ -- custom folder icon
  override = {
    lir_folder_icon = {
      icon = '',
      color = '#7ebae4',
      name = 'LirFolderNode',
    },
  },
})

require('lir').setup({
  show_hidden_files = false,
  devicons_enable = true,
  mappings = {
    ['l'] = actions.edit,
    ['<CR>'] = actions.edit,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,
    ['h'] = actions.up,
    ['-'] = actions.up,
    ['q'] = actions.quit,
    ['<ESC>'] = actions.quit,
    ['K'] = actions.mkdir,
    ['N'] = actions.newfile,
    ['R'] = actions.rename,
    -- ['@']     = actions.cd,
    ['Y'] = actions.yank_path,
    ['.'] = actions.toggle_show_hidden,
    ['z'] = actions.toggle_show_hidden,
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
  hide_cursor = true,
})

require('lir.git_status').setup({
  show_ignored = false,
})

local function refactor(prompt_bufnr)
  local content = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
  require('telescope.actions').close(prompt_bufnr)
  require('refactoring').refactor(content.value)
end

function _G.refactors()
  require('telescope.pickers').new({}, {
    prompt_title = 'refactors',
    finder = require('telescope.finders').new_table({
      results = require('refactoring').get_refactors(),
    }),
    sorter = require('telescope.config').values.generic_sorter({}),
    attach_mappings = function(_, map)
      map('i', '<CR>', refactor)
      map('n', '<CR>', refactor)
      return true
    end,
  }):find()
end

function _G.ToggleNums()
  cmd([[set number! relativenumber!]])
  -- cmd([[Gitsigns toggle_signs]])
end

function _G.Lsp_Info()
  local warnings = vim.lsp.diagnostic.get_count(0, 'Warning')
  local errors = vim.lsp.diagnostic.get_count(0, 'Error')
  local hints = vim.lsp.diagnostic.get_count(0, 'Hint')
  return string.format('H %d W %d E %d', hints, warnings, errors)
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
=======
local actions = require("lir.actions")
-- local mark_actions = require("lir.mark.actions")
-- local clipboard_actions = require'lir.clipboard.actions'

-- local textsubjects = require('binds').textsubjects
local textobjects = require("binds").textobjects
local playground = require("binds").playground
local cmp_binds = require("binds").cmp_binds

local cmp_formatting = {}
if in_gui then
cmp_formatting =
		{ format = function(entry, vim_item)
			vim_item.kind = require("lspkind").presets.default[vim_item.kind]
			vim_item.menu = ({
				spell = "",
				buffer = "",
				calc = "",
				emoji = "",
				path = "/",
				latex_symbols = "λ",
				luasnip = "",
				nvim_lua = "",
				nvim_lsp = "",
			})[entry.source.name]
			return vim_item
		end,
	}
else --in tty
cmp_formatting = { format = function(entry, vim_item)
			-- fancy icons and a name of kind
			-- vim_item.kind = require("lspkind").presets.default[vim_item.kind]
			-- .. ' '
			-- .. vim_item.kind
			-- set a name for each source
			vim_item.menu = ({
				spell = "[Sp]",
				buffer = "[Bu]",
				calc = "[Ca]",
				emoji = "[Em]",
				path = "[Pa]",
				latex_symbols = "[La]",
				luasnip = "[Sn]",
				nvim_lua = "[Lu]",
				nvim_lsp = "[Ls]",
			})[entry.source.name]
			return vim_item
		end,
	}
end

-- local g = vim.g
-- require('lspsaga').init_lsp_saga()
require("dap").defaults.fallback.terminal_win_cmd = "35vsplit new"
require("nvim_comment").setup()
require("treesitter-context.config").setup()
require("refactoring").setup()
require("luasnip/loaders/from_vscode").load()

require("which-key").setup({
	plugins = {
		spelling = {
			enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		}
	}
})

require("cmp").setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	mapping = cmp_binds,

	sources = {
		{ name = "spell" },
		{ name = "buffer" },
		{ name = "calc" },
		{ name = 'emoji' },
		{ name = "path" },
		{ name = "latex_symbols" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "tmux" },
	},

	formatting = cmp_formatting,
})

require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
	},
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
	use_internal_diff = true, -- If luajit is present
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
	hide_cursor = true,
})

require("lir.git_status").setup({
	show_ignored = false,
})

local function refactor(prompt_bufnr)
	local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
	require("telescope.actions").close(prompt_bufnr)
	require("refactoring").refactor(content.value)
end

function _G.refactors()
	require("telescope.pickers").new({}, {
		prompt_title = "refactors",
		finder = require("telescope.finders").new_table({
			results = require("refactoring").get_refactors(),
		}),
		sorter = require("telescope.config").values.generic_sorter({}),
		attach_mappings = function(_, map)
			map("i", "<CR>", refactor)
			map("n", "<CR>", refactor)
			return true
		end,
	}):find()
end

function _G.ToggleNums()
	cmd([[set number! relativenumber!]])
	-- cmd([[Gitsigns toggle_signs]])
end

function _G.Lsp_Info()
	local warnings = vim.lsp.diagnostic.get_count(0, "Warning")
	local errors = vim.lsp.diagnostic.get_count(0, "Error")
	local hints = vim.lsp.diagnostic.get_count(0, "Hint")
	return string.format("H %d W %d E %d", hints, warnings, errors)
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

-- -- use visual mode
-- function _G.LirSettings()
--   vim.api.nvim_buf_set_keymap(0, 'x', 'J', ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>', {noremap = true, silent = true})
--   echo cwd
--   vim.api.nvim_echo({{vim.fn.expand('%:p'), 'Normal'}}, false, {})
-- end

-- cmd([[augroup lir-settings]])
-- cmd([[  autocmd!]])
-- cmd([[  autocmd Filetype lir :lua LirSettings()]])
-- cmd([[augroup END]])

-- function _G.ToggleNums ()
--   vim.cmd([[set number! relativenumber!]])
--   require('gitsigns').signcolumn = not require('gitsigns').signcolumn
-- end
>>>>>>> refs/remotes/origin/master
