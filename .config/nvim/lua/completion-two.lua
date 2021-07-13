require('compe').setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  resolve_timeout = 800,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  },

  source = {
    path = true,
    spell = {filetypes = {'markdown', 'tex'}},
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = false,
    vsnip = true,
    ultisnips = true,
    luasnip = false,
  },
}

local col = vim.fn.col
local complete_info = vim.fn.complete_info
local getline = vim.fn.getline
local pumvisible = vim.fn.pumvisible

local compe_complete = vim.fn['compe#complete']
local compe_confirm = vim.fn['compe#confirm']
local vsnip_available = vim.fn['vsnip#available']
local vsnip_jumpable = vim.fn['vsnip#jumpable']

local function t(code)
  return replace_termcodes(code, true, true, true)
end

local map = vim.api.nvim_set_keymap

local function is_space_before()
  local c = col('.') - 1
  return c == 0 or getline('.'):sub(c, c):match('%s')
end

_G.completion_tab = function()
  if pumvisible() == 1 then
    return t'<C-n>'
  elseif vsnip_available(1) == 1 then
    return t'<Plug>(vsnip-expand-or-jump)'
  elseif is_space_before() then
    return t'<Tab>'
  else
    return compe_complete()
  end
end

_G.completion_s_tab = function()
  if pumvisible() == 1 then
    return t'<C-p>'
  elseif vsnip_jumpable(-1) == 1 then
    return t'<Plug>(vsnip-jump-prev)'
  else
    return t'<S-Tab>'
  end
end

_G.completion_cr = function()
  if pumvisible() == 1 then
    if complete_info().selected ~= -1 then
      return compe_confirm(t'<CR>')
    else
      return t'<CR>'
    end
  else
    return t'<CR>'
  end
end
