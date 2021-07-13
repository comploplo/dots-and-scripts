local opt = vim.opt
local g = vim.g
local env = vim.env
local hi = vim.highlight

hi.create('WhichKeyFloat', { ctermbg = 0, guibg = 'background' }, false)

opt.smartindent                   = true
opt.shell                         = 'bash'                                -- shell to use for `!`, `:!`, `system()` etc.
opt.shiftround                    = false                                 -- don't always indent by multiple of shiftwidth
opt.shiftwidth                    = 2                                     -- spaces per tab (when shifting)
opt.shortmess                     = opt.shortmess + 'A'                   -- ignore annoying swapfile messages
opt.shortmess                     = opt.shortmess + 'I'                   -- no splash screen
opt.shortmess                     = opt.shortmess + 'O'                   -- file-read message overwrites previous
opt.shortmess                     = opt.shortmess + 'T'                   -- truncate non-file messages in middle
opt.shortmess                     = opt.shortmess + 'W'                   -- don't echo "[w]"/"[written]" when writing
opt.shortmess                     = opt.shortmess + 'a'                   -- use abbreviations in messages eg. `[RO]` instead of `[readonly]`
opt.shortmess                     = opt.shortmess + 'c'                   -- completion messages
opt.shortmess                     = opt.shortmess + 'o'                   -- overwrite file-written messages
opt.shortmess                     = opt.shortmess + 't'                   -- truncate file messages at start
opt.showbreak                     = '↳ '                                  -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
opt.showcmd                       = false                                 -- don't show extra info at end of command line
opt.sidescroll                    = 0                                     -- sidescroll in jumps because terminals are slow
opt.sidescrolloff                 = 3                                     -- same as scrolloff, but for columns
opt.smarttab                      = true                                  -- <tab>/<BS> indent/dedent in leading whitespace

opt.swapfile                      = false                                 -- undotree settings
opt.backup                        = false
opt.undodir                       = env.HOME .. [[/.config/nvim/undo]]
opt.undofile                      = true

opt.exrc                          = true                                  -- auto source .vimrc in file when 'vim .' in that file

opt.hlsearch                      = false                                 -- search settings
opt.ignorecase                    = true
opt.smartcase                     = true
opt.incsearch                     = true

opt.hidden                        = true                                  -- keeps unsaved files open in background

opt.autoindent                    = true
opt.cmdheight                     = 2
opt.completeopt                   = 'menuone,noselect'
opt.digraph                       = false
opt.encoding                      = 'UTF-8'
opt.inccommand                    = 'nosplit'
opt.incsearch                     = true
opt.listchars                     = 'tab:| ,trail:.,extends:>,precedes:<'
opt.mouse                         = 'a'
opt.errorbells                    = false
opt.showmode                      = false
opt.wrap                          = false
opt.scrolloff                     = 8
opt.sidescrolloff                 = 1
opt.tabpagemax                    = 6
opt.termguicolors                 = true
opt.updatetime                    = 50
opt.foldmethod                    = 'expr'
opt.foldexpr                      = 'nvim_treesitter#foldexpr()'

opt.belloff                       = 'all'                                 -- never ring the bell for any reason
opt.completeopt                   = 'menuone'                             -- show menu even if there is only one candidate (for nvim-compe)
opt.completeopt                   = vim.opt.completeopt + 'noselect'      -- don't automatically select canditate (for nvim-compe)
opt.cursorline                    = true                                 -- highlight current line
opt.diffopt                       = vim.opt.diffopt + 'foldcolumn:0'      -- don't show fold column in diff view
opt.emoji                         = false                                 -- don't assume all emoji are double width
opt.expandtab                     = true                                  -- always use spaces instead of tabs
opt.fillchars                     = {
  diff                            = '∙',                                  -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob                             = ' ',                                  -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  fold                            = '·',                                  -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert                            = '|',                                  -- just an or, |
  -- vert                            = '┃',                                  -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83), actual letter: '┃'
}

opt.foldlevelstart                = 99                                    -- start unfolded
opt.formatoptions                 = opt.formatoptions + 'j'               -- remove comment leader when joining comment lines
opt.formatoptions                 = opt.formatoptions + 'n'               -- smart auto-indenting inside numbered lists

opt.spellcapcheck                 = ''                                    -- don't check for capital letters at start of sentence
opt.splitbelow                    = false                                 -- open horizontal splits below current window
opt.splitright                    = true                                  -- open vertical splits to the right of the current window
opt.textwidth                     = 80                                    -- automatically hard wrap at 80 columns

g.netrw_banner                    = 0
g.netrw_liststyle                 = 3
g.netrw_browse_split              = 4
g.netrw_altv                      = 1
g.netrw_winsize                   = 25

g.limelight_conceal_ctermfg       = 'gray'                                -- used with goyo
g.limelight_conceal_guifg         = 'DarkGray'

g.diagnostic_enable_virtual_text  = 1
g.diagnostic_insert_delay         = 1
g.diagnostic_show_sign            = 0
g.diagnostic_virtual_text_prefix  = ' '
g.space_before_virtual_text       = 5
g.diagnostic_trimmed_virtual_text = '20'

g.translate_source                = "en"
g.translate_target                = "es"
g.translate_popup_window          = 0                                     -- if you want use popup window, set value 1
g.translate_winsize               = 1                                     -- set buffer window height size if you doesn't use popup window

g.user_emmet_install_global       = 0

-- opt.tabstop                                                               = 4  -- tap options
-- opt.softtabstop                                                           = 4
-- opt.shiftwidth                                                            = 4
-- opt.expandtab                                                             = true

-- for ranger
-- g.rnvimr_ex_enable                                                        = 0
-- g.rnvimr_draw_border                                                      = 1
-- g.rnvimr_pick_enable                                                      = 0
-- g.rnvimr_bw_enable                                                        = 0

-- g.dirvish_mode                                                               = 1
-- g.loaded_netrwPlugin                                                         = 1

-- g.UltiSnipsEditSplit                                                      = 'vertical'

-- g.completion_enable_snippet                                               = 'UltiSnips'
-- g.completion_enable_snippet                                               = 'vim-vsnip'
-- g.completion_matching_strategy_list                                       = { 'exact', 'substring', 'fuzzy' }

-- set cc                                                                    = 80
-- set wildmenu
-- set digraph

