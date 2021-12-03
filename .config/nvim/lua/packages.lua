require("paq")({
  --package manager
  "savq/paq-nvim",

  --lsp
  -- 'github/copilot.vim',
  "neovim/nvim-lspconfig",

  --completion
  "hrsh7th/nvim-cmp",
  "f3fora/cmp-spell",
  "honza/vim-snippets",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-calc",
  "hrsh7th/cmp-emoji",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-path",
  "saadparwaiz1/cmp_luasnip",
  "l3mon4d3/luasnip",
  "ray-x/cmp-treesitter",
  "kdheepak/cmp-latex-symbols",
  "onsails/lspkind-nvim",

  --git
  "tpope/vim-fugitive",
  "lewis6991/gitsigns.nvim",
  "tamago324/lir-git-status.nvim",

  -- new movements
  "terrortylor/nvim-comment",
  "andymass/vim-matchup",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "blackCauldron7/surround.nvim",

  --cosmetics
  "eddyekofo94/gruvbox-flat.nvim",
  "folke/twilight.nvim",
  "folke/zen-mode.nvim",
  "glepnir/lspsaga.nvim",
  "jubnzv/virtual-types.nvim",
  "kyazdani42/nvim-web-devicons",
  "romgrk/nvim-treesitter-context",
  "morhetz/gruvbox",
  "nvim-lua/popup.nvim",
  "ray-x/lsp_signature.nvim",
  "theprimeagen/harpoon",
  -- "rrethy/vim-illuminate",

  --information
  -- "folke/trouble.nvim",
  "folke/which-key.nvim",
  "nvim-treesitter/playground",
  "simrat39/symbols-outline.nvim",
  "mbbill/undotree",
  "code-biscuits/nvim-biscuits",

  "mhartington/formatter.nvim",
  "mfussenegger/nvim-dap",
  "nathom/filetype.nvim",
  "nvim-lua/plenary.nvim",
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
  "skanehira/translate.vim",
  "tamago324/lir.nvim",

  -- 'junegunn/gv.vim',
  -- 'theprimeagen/refactoring.nvim',
  -- 'godlygeek/tabular',
  -- 'nvim-telescope/telescope-fzy-native.nvim',
  -- 'nvim-telescope/telescope.nvim',
  -- 'Th3Whit3Wolf/spacebuddy',
  -- 'andersevenrud/compe-tmux',
  -- 'ericjuma/neowal',
  -- 'hrsh7th/nvim-compe',
  -- 'hrsh7th/vim-vsnip',
  -- 'hrsh7th/vim-vsnip-integ',
  -- 'humanoid-colors/vim-humanoid-colorscheme',
  -- 'jose-elias-alvarez/nvim-lsp-ts-utils',
  -- 'junegunn/goyo.vim',
  -- 'junegunn/limelight.vim',
  -- 'justinmk/vim-dirvish',
  -- 'kana/vim-textobj-user',
  -- 'kevinhwang91/rnvimr',
  -- 'kovetskiy/sxhkd-vim',
  -- 'lambdalisue/fern-hijack.vim',
  -- 'lambdalisue/fern.vim',
  -- 'lewis6991/spellsitter.nvim',
  -- 'mattn/emmet-vim',
  -- 'mfussenegger/nvim-lint',
  -- 'norcalli/nvim-colorizer.lua',
  -- 'norcalli/typeracer.nvim', -- gets a luv error
  -- 'nvim-lua/completion-nvim',
  -- 'preservim/nerdtree',
  -- 'psf/black',
  -- 'rafamadriz/friendly-snippets',
  -- 'rhysd/clever-f.vim',
  -- 'rrethy/nvim-treesitter-textsubjects',
  -- 'ryanoasis/vim-devicons',
  -- 'saihoooooooo/vim-textobj-space',
  -- 'sheerun/vim-polyglot',
  -- 'sirver/ultisnips',
  -- 'tjdevries/colorbuddy.nvim',
  -- 'tjdevries/gruvbuddy.nvim',
  -- 'tomtom/tcomment_vim',
  -- 'tpope/vim-surround',
  -- 'vim-pandoc/vim-pandoc-syntax',
  -- 'wbthomason/packer.nvim',
  -- 'windwp/nvim-autopairs',
  -- 'xiaoyaoliu/vista.vim',
  -- 'yamatsum/nvim-nonicons',
  -- 'ms-jpq/coq_nvim',
  -- 'ms-jpq/coq.artifacts',
  -- 'ms-jpq/coq.thirdparty',
  -- 'lervag/vimtex',
})
