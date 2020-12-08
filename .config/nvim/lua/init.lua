local on_attach_vim = function(client)
    require'completion'.on_attach(client)
end
require'lspconfig'.pyls.setup{ 
    on_attach=on_attach_vim,
    init_options = {
        formatter = black
    }
}
require'lspconfig'.html.setup{
    on_attach=on_attach_vim,
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true
        }
    }
}
require'lspconfig'.texlab.setup{ on_attach=on_attach_vim }
require'lspconfig'.bashls.setup{ on_attach=on_attach_vim }
require'lspconfig'.vimls.setup{ on_attach=on_attach_vim }
require'lspconfig'.jdtls.setup{ on_attach=on_attach_vim }
require'lspconfig'.sumneko_lua.setup{ 
    on_attach=on_attach_vim,
    cmd = { "/home/gabe/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/bin/Linux/lua-language-server", "-E", "/home/gabe/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua" },
}
require'lspconfig'.jsonls.setup{ on_attach=on_attach_vim }

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
}
