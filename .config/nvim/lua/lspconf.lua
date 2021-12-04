local nvim_lsp = require("lspconfig")
local sumneko_root_path = "/home/gabe/programming/repos/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
local lsp_binds = require("binds").lsp_binds

-- I would use this if i used virtual text 😄
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--   virtual_text = {
--     prefix = "●", -- Could be '●', '▎', 'x', '■'
--   },
-- })

local on_attach = function(_, bufnr)
  --Enable completion triggered by <c-x><c-o>
  vim.cmd([[setlocal omnifunc=v:lua.vim.lsp.omnifunc]])

  -- enable gq based on lsp formatting
  vim.cmd([[setlocal formatexpr=v:lua.vim.lsp.formatexpr()]])

  lsp_binds(bufnr)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = vim.g.border, focusable = false }
  )
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = vim.g.border, focusable = false }
  )

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
