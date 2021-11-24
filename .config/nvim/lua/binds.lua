vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap
local cmd = vim.cmd
-- local g = vim.g
-- local bufmap = vim.api.nvim_buf_set_keyma

local opts = { silent = true, noremap = true }
local optsexpr = { silent = false, noremap = true, expr = true }
local optsloud = { noremap = true }
-- local optsexpr = { silent = true, noremap = true, expr = true }

-- map('', '', [[]], opts )

map("", "-", [[:lua require'lir.float'.init()<CR>]], opts)
map("", "<C-s>", [[:w<CR>]], opts)

map("", "<leader>tz", [[:ZenMode<CR>]], opts) -- toggle block
map("", "<leader>tn", [[:lua ToggleNums()<CR>]], opts)
map("", "<leader>tu", [[:UndotreeToggle<CR>]], opts)
map("", "<leader>ts", [[:SymbolsOutline<CR>]], opts)
map("", "<leader>tg", [[:Gitsigns toggle_signs<CR>]], opts)
map("", "<leader>tt", [[:TSPlaygroundToggle<CR>]], opts)
map("", "<leader>tc", [[:TSContextToggle<CR>]], opts)

map("", "<leader>bb", [[:buffers<CR>]], opts)
map("", "<leader>bn", [[:bnext<CR>]], opts)
map("", "<leader>bp", [[:bprev<CR>]], opts)
map("", "<leader>be", [[:bprev<CR>]], opts)

map("", "Y", [[y$]], opts)
map("", "n", [[nzzzv]], opts)
map("", "N", [[Nzzzv]], opts)
map("", "J", [[mzJ'z]], opts)

map("o", "ib", [[:<c-u>normal! mzggVG<cr>`z]], opts)

map("t", "<esc>", [[<C-\><C-n>]], opts)

map("v", "<", [[<gv]], opts)
map("v", ">", [[>gv]], opts)
map("v", "J", [[:m '>+1<CR>gv=gv]], opts)
map("v", "K", [[:m '<-2<CR>gv=gv]], opts)

map("n", "<leader>k", [[:m.-2<CR>==]], optsloud)
map("n", "<leader>j", [[:m.+1<CR>==]], optsloud)

map("v", "<S-y>", [["+y]], optsloud)
map("v", "<leader>y", [["+y]], optsloud)

map("n", "<leader>y", [["+y]], optsloud)
map("n", "<leader>Y", [[ gg"+yG]], optsloud)

map("n", "<leader>w", [[<C-w>]], opts)
map("n", "<C-j>", [[:cnext<CR>zzzv]], opts)
map("n", "<C-k>", [[:cprev<CR>zzzv]], opts)
map("n", "k", [[(v:count > 5 ? "m'" . v:count : "") . 'k']], optsexpr)
map("n", "j", [[(v:count > 5 ? "m'" . v:count : "") . 'j']], optsexpr)

map("n", "<C-u>", [[<C-u>zzzv]], opts)
map("n", "<C-d>", [[<C-d>zzzv]], opts)

map("n", "<M-s>", [[:setlocal spell! spelllang=en_us<CR>]], optsloud)
map("n", "<M-S-s>", [[:setlocal spell! spelllang=es_es<CR>]], optsloud)
map("n", "<S-M-t>", [[:Translate! ]], optsloud)
map("n", "<M-t>", [[:Translate ]], optsloud)

map("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", opts)
map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", opts)
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
map("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)

map("i", ",", [[,<C-g>u]], opts)
map("i", ".", [[.<C-g>u]], opts)
map("i", "!", [[!<C-g>u]], opts)
map("i", "?", [[?<C-g>u]], opts)

map("i", "jk", [[<esc>]], opts)
map("i", "kj", [[<esc>]], opts)
map("i", "jj", [[<esc>]], opts)

map("n", "<leader>dc", [[:lua require'dap'.continue()<CR>]], opts)
map("n", "<M-d>", [[:lua require'dap'.continue()<CR>]], opts)
map("n", "<leader>do", [[:lua require'dap'.step_over()<CR>]], opts)
map("n", "<leader>di", [[:lua require'dap'.step_into()<CR>]], opts)
map("n", "<leader>dO", [[:lua require'dap'.step_out()<CR>]], opts)
map("n", "<leader>db", [[:lua require'dap'.toggle_breakpoint()<CR>]], opts)
map("n", "<leader>dB", [[:lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]], opts)
map("n", "<leader>dp", [[:lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]], opts)
map("n", "<leader>dr", [[:lua require'dap'.repl.open()<CR>]], opts)
map("n", "<leader>dl", [[:lua require'dap'.run_last()<CR>]], opts)

map("v", "<Leader>re", [[ <Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], opts)
map("v", "<Leader>rf", [[ <Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], opts)
map("v", "<Leader>rt", [[ <Cmd>lua refactors()<CR>]], opts)

-- map('', '<C-j>',          [[<C-w>j]],                                                                      opts )
-- map('', '<C-k>',          [[<C-w>k]],                                                                      opts )
-- map('', '<C-l>',          [[<C-w>l]],                                                                      opts )
-- map('', '<C-h>',          [[<C-w>h]],                                                                      opts )

-- map('', '<leader><S-w>',  [[:luafile ~/.local/share/nvim/site/pack/paqs/start/neowal/lua/neowal.lua<CR>]], opts )

-- map('n', '<leader>ff', [[:lua require('teleconf').find_files()<CR>]],   opts ) -- not using telescope right now bcause i have no need.
-- map('n', '<leader>fg', [[:lua require('teleconf').live_grep()<CR>]],    opts )
-- map('n', '<leader>fh', [[:lua require('teleconf').help_tags()<CR>]],    opts )
-- map('n', '<leader>fc', [[:lua require('teleconf').find_conf()<CR>]],    opts )
-- map('n', '<leader>fb', [[:lua require('teleconf').local_browse()<CR>]], opts )

-- The following list was made with a macro that employed the following:
-- "let @z = char2nr(matchstr(getline('.'), '%'.col('.').'c.'))"
cmd("digraph !! 161") -- ¡
cmd("digraph ?? 191") -- ¿
cmd("digraph +- 177") -- ±
cmd("digraph dh 240") -- ð
cmd("digraph dj 676") -- ʤ
cmd("digraph gs 660") -- ʔ
cmd("digraph ps 712") -- ˈ
cmd("digraph ss 716") -- ˌ
cmd("digraph rr 633") -- ɹ
cmd("digraph sh 643") -- ʃ
cmd("digraph ts 679") -- ʧ
cmd("digraph uh 652") -- ʌ
cmd("digraph zh 658") -- ʒ
cmd("digraph th 952") -- θ

local M = {}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach_binds = function(bufnr)
	local function bmap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function bopt(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	--Enable completion triggered by <c-x><c-o>
	bopt("omnifunc", "v:lua.vim.lsp.omnifunc")

	bmap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	bmap("n", "<C-S-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	bmap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	bmap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	bmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	bmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	bmap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	bmap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	bmap("n", "<Leader>pa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	bmap("n", "<Leader>pr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	bmap("n", "<Leader>pl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	bmap("n", "<Leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	bmap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	bmap("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	bmap("n", "<Leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	bmap("n", "<Leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	bmap("n", "<Leader>fo", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

M.textobjects = {
	swap = {
		enable = true,
		swap_next = { ["<leader>a"] = "@parameter.inner" },
		swap_previous = { ["<leader>A"] = "@parameter.inner" },
	},
	move = {
		enable = true,
		set_jumps = true, -- whether to set jumps in the jumplist
		goto_next_start = { ["]m"] = "@function.outer" },
		goto_next_end = { ["]M"] = "@function.outer" },
		goto_previous_start = { ["[m"] = "@function.outer" },
		goto_previous_end = { ["[M"] = "@function.outer" },
	},
	lsp_interop = {
		enable = true,
		-- border = 'none',
		peek_definition_code = {
			["<leader>df"] = "@function.outer",
			["<leader>dF"] = "@class.outer",
		},
	},
	select = {
		enable = true,

		-- Automatically jump forward to textobj, similar to targets.vim
		lookahead = true,

		keymaps = {
			-- You can use the capture groups defined in textobjects.scm
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["ac"] = "@class.outer",
			["ic"] = "@class.inner",

			-- Or you can define your own textobjects like this
			["iF"] = {
				python = "(function_definition) @function",
				cpp = "(function_definition) @function",
				c = "(function_definition) @function",
				java = "(method_declaration) @function",
			},
		},
	},
}

M.playground = { -- Treesitter playground config
	enable = true,
	keybindings = {
		toggle_query_editor = "o",
		toggle_hl_groups = "i",
		toggle_injected_languages = "t",
		toggle_anonymous_nodes = "a",
		toggle_language_display = "I",
		focus_language = "f",
		unfocus_language = "F",
		update = "R",
		goto_node = "<cr>",
		show_help = "?",
	},
}

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")
M.cmp_binds = {
	["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
	["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
	["<c-y>"] = cmp.mapping(
		cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		{ "i", "c" }
	),
	["<c-space>"] = cmp.mapping({
		i = cmp.mapping.complete(),
		c = function(
			_ --[[fallback]]
		)
			if cmp.visible() then
				if not cmp.confirm({ select = true }) then
					return
				end
			else
				cmp.complete()
			end
		end,
	}),
	["<C-e>"] = cmp.mapping({
		i = cmp.mapping.abort(),
		c = cmp.mapping.close(),
	}),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	-- super-tab experience
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		elseif has_words_before() then
			cmp.complete()
		else
			fallback()
		end
	end, {
		"i",
		"s",
	}),
	["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, {
		"i",
		"s",
	}),
}

return M
