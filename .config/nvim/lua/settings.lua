require('which-key').setup { }
require('colorbuddy').colorscheme('neowal')
require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
}

require('telescope').setup {
	estensions = {
		fzy_native = {
			override_generig_sortor = false,
			override_file_sorter = true,
		}
	}
}

local opt = vim.opt
local g = vim.g
local env = vim.env
local hi = vim.highlight
local cmd = vim.cmd

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth=4
opt.expandtab = true
opt.smartindent = true

-- undotree
opt.swapfile = false
opt.backup = false
opt.undodir = env.HOME .. [[/.config/nvim/undo]]
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
opt.sidescrolloff = 1
opt.tabpagemax = 6
opt.termguicolors = true
opt.updatetime = 50
opt.foldmethod = 'syntax'

g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_browse_split = 4
g.netrw_altv = 1
g.netrw_winsize = 25

g.colorscheme = 'gruvbox'

-- limelight lowlight highlight settings, used in goyo
g.limelight_conceal_ctermfg = 'gray'
g.limelight_conceal_guifg = 'DarkGray'

-- completion
g.diagnostic_enable_virtual_text = 1
g.diagnostic_insert_delay = 1
g.diagnostic_show_sign = 0
g.diagnostic_virtual_text_prefix = ' '
g.space_before_virtual_text = 5
g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }
g.diagnostic_trimmed_virtual_text = '20'

-- translate from english to spanish
g.translate_source = "en"
g.translate_target = "es"
g.translate_popup_window = 0 -- if you want use popup window, set value 1
g.translate_winsize = 1 -- set buffer window height size if you doesn't use popup window

g.user_emmet_install_global = 0

-- for ranger
g.rnvimr_ex_enable = 0
g.rnvimr_draw_border = 1
g.rnvimr_pick_enable = 0
g.rnvimr_bw_enable = 0

-- g.dirvish_mode = 1
-- g.loaded_netrwPlugin = 1

hi.create('WhichKeyFloat', { ctermbg = 0, guibg = 'background' }, false)

-- This makes dirvish replace netrw
cmd([[
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
]])
