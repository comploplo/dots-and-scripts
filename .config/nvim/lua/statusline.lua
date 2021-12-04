local write_count = 0

function Lsp_Info()
  local warnings = #vim.diagnostic.get(vim.g.bufnr, { severity = vim.diagnostic.severity.WARN })
  local errors = #vim.diagnostic.get(vim.g.bufnr, { severity = vim.diagnostic.severity.ERROR })
  local hints = #vim.diagnostic.get(vim.g.bufnr, { severity = vim.diagnostic.severity.ERROR })
  return string.format("H %d W %d E %d", hints, warnings, errors)
end

function StatusLine()
  return string.format(write_count) .. [[ %f %y %m %= %p%% %l:%c %{get(b:,'gitsigns_status','')} %{v:lua.Lsp_Info()}]]
end

vim.o.statusline = "%!v:lua.StatusLine()"
-- opt.statusline =  [[%f %y %m %= %p%% %l:%c %{get(b:,'gitsigns_status','')} %{v:lua.Lsp_Info()}]]

M = {}

M.on_write = function()
  write_count = write_count + 1
end

M.set_write = function(count)
  write_count = count
end

vim.api.nvim_exec(
  [[
augroup THEPRIMEAGEN_STATUSLINE
    autocmd!
    autocmd BufWritePre * :lua require("statusline").on_write()
augroup END
 ]],
  false
)

return M
