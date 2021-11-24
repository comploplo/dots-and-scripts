local write_count = 0

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
