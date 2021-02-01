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
lsp.texlab.setup{ on_attach=on_attach_vim }
lsp.bashls.setup{ on_attach=on_attach_vim }
lsp.vimls.setup{ on_attach=on_attach_vim }
lsp.jdtls.setup{ on_attach=on_attach_vim }
lsp.sumneko_lua.setup{ 
    on_attach=on_attach_vim,
    cmd = { "/home/gabe/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/bin/Linux/lua-language-server", "-E", "/home/gabe/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua" },
}
lsp.jsonls.setup{ on_attach=on_attach_vim }
