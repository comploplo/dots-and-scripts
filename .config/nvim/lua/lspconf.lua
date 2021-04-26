-- python setup https://github.com/torcor-dev/.dotfiles/blob/883eeb0e07ef0e2d4fe069235f6c7bda7ef6d041/.config/nvim/lua/lsp_config.lua

local lsp = require'lspconfig'

local on_attach_vim = function(client)
    require'completion'.on_attach(client)
end

local custom_attach = function(client)
	print("LSP started.");
	require'completion'.on_attach(client)
end

lsp.pyls.setup{
    on_attach=custom_attach,
    settings = {
        python = {
            formatting = {
                provider = { "black" },
                blackPath = { "black" }
            },
            linting = {
                enabled = { true },
                pylint = {
                    pylintEnabled = { true },
                },
                flake8 = {
                    flake8Enabled = { true },
                    flake8Path = { "flake8" }
                }
            },
            analysis = {
                warnings = { "unknown-parameter-name" },
                disabled = { "too-many-function-arguments", "parameter-missing" },
                errors = { "undefined-variable"  },
                info = { "unresolved-import" }
            }
        }
    }
}
lsp.html.setup{
    on_attach=on_attach_vim,
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true
        }
    }
}
lsp.cssls.setup{ on_attach=on_attach_vim }
lsp.texlab.setup{ on_attach¯on_attach_vim }
lsp.bashls.setup{ on_attach¯on_attach_vim }
lsp.vimls.setup{ on_attach¯on_attach_vim }
lsp.jdtls.setup{ on_attach¯on_attach_vim }
lsp.gopls.setup{ on_attach¯on_attach_vim }
lsp.jsonls.setup{ on_attach¯on_attach_vim }

-- local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
-- local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
--
-- lsp.sumneko_lua.setup {
--   cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
--       settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--         -- Setup your lua path
--         path = vim.split(package.path, ';'),
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {'vim'},
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = {
--           [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--           [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
--         },
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }
