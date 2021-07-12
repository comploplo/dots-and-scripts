-- python setup https://github.com/torcor-dev/.dotfiles/blob/883eeb0e07ef0e2d4fe069235f6c7bda7ef6d041/.config/nvim/lua/lsp_config.lua

local nvim_lsp = require'lspconfig'
local sumneko_root_path = '/home/gabe/programming/repos/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
local sign_define = vim.fn.sign_define

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function bmap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function bopt(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  bopt('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  bmap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  bmap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  bmap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  bmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  bmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  bmap('n', '<Leader>pa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  bmap('n', '<Leader>pr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  bmap('n', '<Leader>pl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  bmap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  bmap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  bmap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  bmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  bmap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  bmap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  bmap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  bmap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  bmap("n", "<Leader>fo", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  print("LSP started.");
  -- require'completion'.on_attach(client)

end

local lua_globals = { "vim" }
local lua_libs = {
    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
}

if vim.fn.filereadable("/usr/share/xsessions/awesome.desktop") then
  -- awesome wm globals
  table.insert(lua_globals, "awesome")
  table.insert(lua_globals, "client")
  table.insert(lua_globals, "root")
  table.insert(lua_globals, "screen")
  -- awesome wm libs
  lua_libs["/usr/share/awesome/lib"] = true
end

nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
	capabilities = capabilities,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = 'LuaJIT',
      -- Setup your lua path
        path = vim.split(package.path, ";")
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = lua_globals
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = lua_libs,
        maxPreload = 10000
      },
      telemetry = { enable = false }
    }
  }
}

nvim_lsp.pyls.setup{
    on_attach=on_attach,
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

nvim_lsp.html.setup{
    on_attach = on_attach,
	capabilities = capabilities,
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true
        }
    }
}

nvim_lsp.ccls.setup{ filetypes = { "c", "cc", "cpp", "objc", "objcpp" } }

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "hls", "tsserver", "cssls", "texlab", "bashls", "vimls", "jdtls", "gopls", "jsonls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach, capabilities = capabilities }
end

sign_define( "LspDiagnosticsSignError", {text = "E", texthl = "LspDiagnosticsError"})
sign_define( "LspDiagnosticsSignWarning", {text = "W", texthl = "LspDiagnosticsWarning"})
sign_define( "LspDiagnosticsSignInformation", {text = "I", texthl = "LspDiagnosticsInformation"})
sign_define( "LspDiagnosticsSignHint", {text = "?", texthl = "LspDiagnosticsHint"})
