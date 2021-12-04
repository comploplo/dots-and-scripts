-- use({
--   "",
--   config = function() end,
-- })

return require("packer").startup(function(use)
  -- use({
  --   "",
  --   config = function() end,
  -- })

  use({
    "tamago324/lir.nvim",
    requires = {
      "tamago324/lir-git-status.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      local actions = require("lir.actions")
      require("lir").setup({
        show_hidden_files = false,
        devicons_enable = true,
        mappings = {
          ["l"] = actions.edit,
          ["<CR>"] = actions.edit,
          ["<C-s>"] = actions.split,
          ["<C-v>"] = actions.vsplit,
          ["<C-t>"] = actions.tabedit,
          ["h"] = actions.up,
          ["-"] = actions.up,
          ["q"] = actions.quit,
          ["<ESC>"] = actions.quit,
          ["K"] = actions.mkdir,
          ["N"] = actions.newfile,
          ["R"] = actions.rename,
          -- ['@']     = actions.cd,
          ["Y"] = actions.yank_path,
          ["."] = actions.toggle_show_hidden,
          ["z"] = actions.toggle_show_hidden,
          -- ['D']     = actions.delete,
          -- ['J'] = function()
          --   mark_actions.toggle_mark()
          --   vim.cmd('normal! j')
          -- end,
          -- ['C'] = clipboard_actions.copy,
          -- ['X'] = clipboard_actions.cut,
          -- ['P'] = clipboard_actions.paste,
        },
        hide_cursor = false,
      })

      require("nvim-web-devicons").setup({ -- custom folder icon
        override = {
          lir_folder_icon = {
            icon = "",
            color = "#7ebae4",
            name = "LirFolderNode",
          },
        },
      })

      require("lir.git_status").setup({
        show_ignored = false,
      })
    end,
  })

  use({
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup({
        filetype = {
          terraform = {
            function()
              return { exe = "terraform", args = { "fmt", "-" }, stdin = true }
            end,
          },
          go = {
            function()
              return { exe = "gofmt", args = {}, stdin = true }
            end,
          },
          python = {
            -- Configuration for psf/black
            function()
              return { exe = "black" }
            end,
          },
          lua = {
            function()
              return {
                exe = "stylua",
                args = { "--config-path " .. os.getenv("HOME") .. "/.config/stylua/stylua.toml", "-" },
                stdin = true,
              }
            end,
          },
          sh = {
            -- Shell Script Formatter
            function()
              return { exe = "shfmt", args = { "-i", 2 }, stdin = true }
            end,
          },
          javascript = {
            -- prettier
            function()
              return {
                exe = "prettier",
                args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
                stdin = true,
              }
            end,
          },
        },
      })
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    cmd = "TSUpdate",
    requires = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "romgrk/nvim-treesitter-context",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true },
        textobjects = require("binds").textobjects,
        playground = require("binds").playground,
      })
      require("treesitter-context.config").setup()
    end,
  })

  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup({
        numhl = false,
        linehl = false,
        watch_index = {
          interval = 1000,
          follow_files = true,
        },
        current_line_blame = false,
        current_line_blame_opts = {
          delay = 1000,
          virt_text_pos = "eol",
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        word_diff = false,
        diff_opts = { internal = true }, -- If luajit is present
        signcolumn = false,
      })
      -- vim.cmd([[autocmd VimEnter * Gitsigns toggle_signs]]) -- here instead of in autocmds.lua
      -- because it has to happen after the other setuff is (lazily) loaded
    end,
  })

  use({
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          width = 0.6, -- width of the Zen window
          height = 1, -- height of the Zen window
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false, -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
          },
          twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
          gitsigns = { enabled = false }, -- disables git signs
          tmux = { enabled = false }, -- disables the tmux statusline
          -- this will change the font size on kitty when in zen mode
          -- to make this work, you need to set the following kitty options:
          -- - allow_remote_control socket-only
          -- - listen_on unix:/tmp/kitty
          kitty = {
            enabled = true,
            font = "+4", -- font size increment
          },
        },
      })
    end,
  })

  use({
    "code-biscuits/nvim-biscuits",
    config = function()
      require("nvim-biscuits").setup({
        toggle_keybind = require("binds").biscuits_bind,
        default_config = {
          max_length = 12,
          min_distance = 5,
          prefix_string = " ⓘ ",
        },
        language_config = {
          html = {
            prefix_string = " 🌐 ",
          },
          javascript = {
            prefix_string = " ✨ ",
            max_length = 80,
          },
          python = {
            disabled = true,
          },
        },
      })
    end,
  })

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "f3fora/cmp-spell",
      "honza/vim-snippets",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "l3mon4d3/luasnip",
      "saadparwaiz1/cmp_luasnip",
      "ray-x/cmp-treesitter",
      "kdheepak/cmp-latex-symbols",
      "onsails/lspkind-nvim",
    },
    config = function()
      require("cmpsetup")
    end,
  })

  use({
    "neovim/nvim-lspconfig",
    requires = "hrsh7th/nvim-cmp",
    config = function()
      require("lspconf")
    end,
  })

  use({
    "mfussenegger/nvim-dap",
    config = function()
      require("dap").defaults.fallback.terminal_win_cmd = "35vsplit new"
    end,
  })

  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        plugins = {
          spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
        },
      })
    end,
  })

  use({
    --lsp
    -- 'github/copilot.vim',

    --completion

    --git
    "tpope/vim-fugitive",
    -- "lewis6991/gitsigns.nvim",

    -- new movements
    -- "terrortylor/nvim-comment",
    "andymass/vim-matchup",

    "blackCauldron7/surround.nvim",

    --cosmetics
    "eddyekofo94/gruvbox-flat.nvim",
    "folke/twilight.nvim",
    "glepnir/lspsaga.nvim",
    "jubnzv/virtual-types.nvim",
    "morhetz/gruvbox",
    "nvim-lua/popup.nvim",
    "ray-x/lsp_signature.nvim",
    "theprimeagen/harpoon",
    -- "rrethy/vim-illuminate",

    --information
    -- "folke/trouble.nvim",
    "simrat39/symbols-outline.nvim",
    "mbbill/undotree",

    "nathom/filetype.nvim",
    "skanehira/translate.vim",
    "wbthomason/packer.nvim",
  })
end)

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
