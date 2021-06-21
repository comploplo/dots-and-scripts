local opt = vim.opt

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth=4
opt.expandtab = true
opt.smartindent = true

-- undotree
opt.swapfile = false
opt.backup = false
opt.undodir = vim.env.HOME .. [[/.config/nvim/undo]]
opt.undofile = true

-- auto source .vimrc in file when 'vim .' in that file
opt.exrc = true

-- search settings
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- keeps unsaved files open in background, allows for fast swap without save
opt.hidden = true

-- set cc=80
-- set wildmenu
-- set digraph

opt.autoindent = true
opt.cmdheight = 2
opt.completeopt = 'menu,menuone,noselect'
opt.digraph = false
opt.encoding = 'UTF-8'
opt.inccommand = 'nosplit'
opt.incsearch = true
opt.listchars = 'tab:| ,trail:.,extends:>,precedes:<'
opt.mouse = 'a'
opt.errorbells = false
opt.showmode = false
opt.wrap = false
opt.scrolloff = 8
-- set shortmess+=c
opt.sidescrolloff = 1
opt.tabpagemax = 6
opt.termguicolors = true
opt.updatetime = 50

opt.foldmethod = 'syntax'

-- -- tpope markdown
-- vim.g.markdown_syntax_conceal = 0
-- vim.g.folding = 0

vim.g.colorscheme = 'gruvbox'

-- limelight lowlight highlight settings, used in goyo
vim.g.limelight_conceal_ctermfg = 'gray'
vim.g.limelight_conceal_guifg = 'DarkGray'

-- completion
vim.g.diagnostic_enable_virtual_text = 1
vim.g.diagnostic_insert_delay = 1
vim.g.diagnostic_show_sign = 0
vim.g.diagnostic_virtual_text_prefix = ' '
vim.g.space_before_virtual_text = 5
vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }
vim.g.diagnostic_trimmed_virtual_text = '20'

-- translate from english to spanish
vim.g.translate_source = "en"
vim.g.translate_target = "es"
vim.g.translate_popup_window = 0 -- if you want use popup window, set value 1
vim.g.translate_winsize = 1 -- set buffer window height size if you doesn't use popup window

vim.g.user_emmet_install_global = 0

-- for ranger
vim.g.rnvimr_ex_enable = 0
vim.g.rnvimr_draw_border = 1
vim.g.rnvimr_pick_enable = 0
vim.g.rnvimr_bw_enable = 0

vim.highlight.create('WhichKeyFloat', { ctermbg = 0, guibg = 'background' }, false)
