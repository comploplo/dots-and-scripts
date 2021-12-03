local nvim_lsp = require("lspconfig")
local sumneko_root_path = "/home/gabe/programming/repos/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
local sign_define = vim.fn.sign_define
local on_attach_binds = require("binds").on_attach_binds

-- Configure diagnostic display
sign_define("DiagnosticSignError", { text = "E", texthl = "DiagnosticError" })
sign_define("DiagnosticSignWarn", { text = "W", texthl = "DiagnosticWarn" })
sign_define("DiagnosticSignInfo", { text = "I", texthl = "DiagnosticInfo" })
sign_define("DiagnosticSignHint", { text = "?", texthl = "DiagnosticHint" })
vim.diagnostic.config({
  virtual_text = {
    severity = vim.diagnostic.severity.ERROR,
    source = "if_many",
  },
  float = {
    severity_sort = true,
    source = "if_many",
    border = "rounded",
    header = {
      "",
      "LspDiagnosticsDefaultWarning",
    },
    prefix = function(diagnostic)
      local diag_to_format = {
        [vim.diagnostic.severity.ERROR] = { "Error", "LspDiagnosticsDefaultError" },
        [vim.diagnostic.severity.WARN] = { "Warning", "LspDiagnosticsDefaultWarning" },
        [vim.diagnostic.severity.INFO] = { "Info", "LspDiagnosticsDefaultInfo" },
        [vim.diagnostic.severity.HINT] = { "Hint", "LspDiagnosticsDefaultHint" },
      }
      local res = diag_to_format[diagnostic.severity]
      return string.format("%s: ", res[1]), res[2]
    end,
  },
  severity_sort = true,
})

local on_attach = function(client, bufnr)
  on_attach_binds(bufnr)
  print("LSP started.")
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

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

nvim_lsp.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
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
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
  },
})

nvim_lsp.ccls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "c", "cc", "cpp", "objc", "objcpp" },
})

-- -- I had to install this myself from https://github.com/artempyanykh/zeta-note/releases
-- -- markdown ls
-- nvim_lsp.zeta_note.setup({
--   cmd = { os.getenv("HOME") .. "/.local/bin/zeta-note" },
-- })

local servers = {
  "bashls",
  "cssls",
  "dockerls",
  "emmet_ls",
  "gopls",
  "hls",
  "jdtls",
  "jsonls",
  "pylsp",
  "rls",
  "svelte",
  "texlab",
  "tsserver",
  "vimls",
  "vuels",
  "yamlls",
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end
