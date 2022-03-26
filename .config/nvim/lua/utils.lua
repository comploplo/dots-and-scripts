local cmd = vim.cmd
-- local in_gui = not (vim.fn.environ().TERM == 'linux')
-- local mark_actions = require('lir.mark.actions')
-- local clipboard_actions = require'lir.clipboard.actions'

-- local textsubjects = require('binds').textsubjects
cmd([[colorscheme OceanicNext]])

-- local g = vim.g
-- require('lspsaga').init_lsp_saga()
-- require("nvim_comment").setup()
-- require('refactoring').setup()
-- require('spellsitter').setup()

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  -- virtual_text = {
  --   severity = vim.diagnostic.severity.ERROR,
  --   source = "if_many",
  -- },
  virtual_text = false,
  float = {
    severity_sort = true,
    source = "if_many",
    border = vim.g.border,
  },
  severity_sort = true,
})

function _G.ToggleNums()
  vim.cmd([[set number! relativenumber!]])
end

function _G.P(v)
  print(vim.inspect(v))
  return v
end

local diagnostics_active = true
function _G.ToggleDiagnostics()
  if diagnostics_active then
    vim.diagnostic.disable()
    diagnostics_active = false
  else
    vim.diagnostic.enable()
    diagnostics_active = true
  end
end

vim.cmd([[
fun! g:PandocSmartExport()
if expand('%:e') == 'md'
write
if 'Ling' =~ expand('%:p:h:t')
let l:pandoccall = 'pandoc ' . expand('%') . ' -o ' . expand('%:p:h') . '/' . expand('%:t:r') . '.pdf --template homework-ling.tex'
else
let l:pandoccall = 'pandoc ' . expand('%') . ' -o ' . expand('%:p:h') . '/' . expand('%:t:r') . '.pdf --template homework.tex --pdf-engine xelatex'
endif
echo l:pandoccall
echo system(l:pandoccall)
else
endif
echo 'invalid file type'
endfun
]])
