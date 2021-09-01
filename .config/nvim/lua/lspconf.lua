local nvim_lsp = require('lspconfig')
local sumneko_root_path = '/home/gabe/programming/repos/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/Linux/lua-language-server'
local sign_define = vim.fn.sign_define
local on_attach_binds = require('binds').on_attach_binds
-- local coq = require "coq"

  local function setup_diagnostics()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true,
        severity_sort = true,
      }
    )
end

local on_attach = function (_, bufnr)
	on_attach_binds(bufnr)
	require "lsp_signature".on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "single"
		}
	}, bufnr)
	setup_diagnostics()
	print("LSP started.")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	},
}

local lua_globals = { 'vim' }
local lua_libs = {
	[vim.fn.expand('$VIMRUNTIME/lua')] = true,
	[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
}

if vim.fn.filereadable('/usr/share/xsessions/awesome.desktop') then
	-- awesome wm globals
	table.insert(lua_globals, 'awesome')
	table.insert(lua_globals, 'client')
	table.insert(lua_globals, 'root')
	table.insert(lua_globals, 'screen')
	-- awesome wm libs
	lua_libs['/usr/share/awesome/lib'] = true
end

nvim_lsp.sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = vim.split(package.path, ';'),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = lua_globals,
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = lua_libs,
				maxPreload = 10000,
			},
			telemetry = { enable = false },
		},
	},
})

nvim_lsp.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		configurationSection = { 'html', 'css', 'javascript' },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
	},
})

nvim_lsp.pylsp.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		pylsp = {
			plugins = {
				pylsp_black = {
					line_length = 120,
				},
			},
		},
	},
})

nvim_lsp.ccls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { 'c', 'cc', 'cpp', 'objc', 'objcpp' },
})

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
	'bashls',
	'cssls',
	-- 'denols',
	'dockerls',
	'gopls',
	'hls',
	-- 'jdtls',
	'jsonls',
	'rls',
	'texlab',
	'tsserver',
	'vimls',
}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

sign_define('LspDiagnosticsSignError', { text = 'E', texthl = 'LspDiagnosticsError' })
sign_define('LspDiagnosticsSignWarning', { text = 'W', texthl = 'LspDiagnosticsWarning' })
sign_define('LspDiagnosticsSignInformation', { text = 'I', texthl = 'LspDiagnosticsInformation' })
sign_define('LspDiagnosticsSignHint', { text = '?', texthl = 'LspDiagnosticsHint' })
