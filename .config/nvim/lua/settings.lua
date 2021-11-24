local opt = vim.opt
local g = vim.g
local env = vim.env
local cmd = vim.cmd
local hi = vim.highlight

-- colorscheme
g.gruvbox_italic_functions = true
g.gruvbox_colors = { hint = "orange", error = "#ff0000" }
g.gruvbox_flat_style = "dark"
g.gruvbox_transparent = true
cmd([[colorscheme gruvbox-flat]])
hi.create("WhichKeyFloat", { ctermbg = 0, guibg = "background" }, false)

opt.shortmess = opt.shortmess + "A" -- ignore annoying swapfile messages
opt.shortmess = opt.shortmess + "I" -- no splash screen
opt.shortmess = opt.shortmess + "O" -- file-read message overwrites previous
opt.shortmess = opt.shortmess + "T" -- truncate non-file messages in middle
opt.shortmess = opt.shortmess + "W" -- don't echo '[w]'/'[written]' when writing
opt.shortmess = opt.shortmess + "a" -- use abbreviations in messages eg. `[RO]` instead of `[readonly]`
opt.shortmess = opt.shortmess + "c" -- completion messages
opt.shortmess = opt.shortmess + "o" -- overwrite file-written messages
opt.shortmess = opt.shortmess + "t" -- truncate file messages at start

-- tab settings
-- opt.autoindent = true
-- opt.shiftround = false -- don't always indent by multiple of shiftwidth
-- opt.shiftwidth = 2 -- spaces per tab (when shifting)
-- opt.showcmd = false -- don't show extra info at end of command line
-- opt.sidescroll = 0 -- sidescroll in jumps because terminals are slow
opt.sidescrolloff = 3 -- same as scrolloff, but for columns
opt.smarttab = true -- <tab>/<BS> indent/dedent in leading whitespace
opt.smartindent = true

-- undotree settings
opt.swapfile = false
opt.backup = false
opt.undodir = env.HOME .. [[/.config/nvim/undo]]
opt.undofile = true

-- search settings
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.inccommand = "nosplit"

-- completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- I never use folding lmao
opt.foldlevelstart = 99 -- start unfolded
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- opt.cursorline = true -- highlight current line
opt.diffopt = vim.opt.diffopt + "foldcolumn:0" -- don't show fold column in diff view
opt.emoji = true -- don't assume all emoji are double width
opt.expandtab = true -- always use spaces instead of tabs
opt.fillchars = {
  diff = "∙", -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob = " ", -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  fold = "·", -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert = "┃", -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83), actual letter: '┃'
  -- vert = '|', -- just an or, |
}

opt.formatoptions = opt.formatoptions + "j" -- remove comment leader when joining comment lines
opt.formatoptions = opt.formatoptions + "n" -- smart auto-indenting inside numbered lists

opt.spellcapcheck = "" -- don't check for capital letters at start of sentence
opt.splitbelow = false -- open horizontal splits below current window
opt.splitright = true -- open vertical splits to the right of the current window
opt.textwidth = 80 -- automatically hard wrap at 80 columns

g.loaded_netrwPlugin = false
-- g.netrw_banner                    = 0
-- g.netrw_liststyle                 = 3
-- g.netrw_browse_split              = 4
-- g.netrw_altv                      = 1
-- g.netrw_winsize                   = 25

-- spanish translation
g.translate_source = "en"
g.translate_target = "es"
g.translate_popup_window = 0 -- if you want use popup window, set value 1
g.translate_winsize = 1 -- set buffer window height size if you doesn't use popup window

-- random settings for qol
opt.shell = "bash" -- shell to use for `!`, `:!`, `system()` etc.
opt.exrc = true -- auto source .vimrc in file when 'vim .' in that file
opt.showbreak = "↳ " -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
opt.hidden = true -- keeps unsaved files open in background
opt.listchars = "tab:» ,trail:.,extends:>,precedes:<,eol:↲"
opt.digraph = false -- require press of  for digraph
opt.encoding = "UTF-8" -- mostly for digraph characters, such as IPA and greek symbols
opt.mouse = "a" -- enable mouse in all modes
g.did_load_filetypes = 1 -- disable filetype.vim, used because I have filetype.nvim
g.user_emmet_install_global = 0
opt.belloff = "all" -- never ring the bell for any reason
-- opt.errorbells = false
opt.cmdheight = 2
opt.showmode = false
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 1
opt.tabpagemax = 6
opt.termguicolors = true
opt.updatetime = 50

