-- use({
--   "",
--   config = function() end,
-- })

return require("packer").startup(function(use)
	--   use({
	--     "nvim-orgmode/orgmode",
	--     ft = { "org" },
	--     requires = { "nvim-treesitter/nvim-treesitter", "milisims/tree-sitter-org" },
	--     config = function()
	--       require("orgmode").setup({
	--         org_agenda_files = { "~/docs/org" },
	--         org_default_notes_file = "~/docs/org/refile.org",
	--       })
	--       local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	--       parser_config.org = {
	--         install_info = {
	--           url = "https://github.com/milisims/tree-sitter-org",
	--           revision = "main",
	--           files = { "src/parser.c", "src/scanner.cc" },
	--         },
	--         filetype = "org",
	--       }
	--     end,
	--   })

	use({
		"filipdutescu/renamer.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("renamer").setup({
				-- Whether or not to shown a border around the popup
				border = false,
				-- Whether or not to highlight the current word references through LSP
				show_refs = true,
				-- Whether or not to add resulting changes to the quickfix list
				with_qf_list = false,
			})
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup()
		end,
	})

	use({
		"tamago324/lir.nvim",
		requires = {
			"tamago324/lir-git-status.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("lir").setup({
				show_hidden_files = false,
				devicons_enable = true,
				mappings = require("binds").lir_binds,
				hide_cursor = false,
				-- You can define a function that returns a table to be passed as the third
				-- argument of nvim_open_win().
				float = {
					winblend = 20,
					curdir_window = {
						enable = false,
						highlight_dirname = true,
					},
					win_opts = function()
						return {
							border = "none",
						}
					end,
				},
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
							return { exe = "black", stdin = false }
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
		run = ":TSUpdate",
--		opt = false,
--		config = function()
--			require("nvim-treesitter.configs").setup({
--				highlight = {
--					enable = true,
--					-- disable = { "org" }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
--					-- additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
--				},
--				-- incremental_selection = { enable = true },
--				-- indent = { enable = true },
--				-- textobjects = require("binds").textobjects,
--				-- playground = require("binds").playground,
--			})
--		end,
	})

	--  use({
	--    "nvim-treesitter/playground",
	--    requires = { "nvim-treesitter/nvim-treesitter", },
	--  })

	--  use({
	--          "romgrk/nvim-treesitter-context",
	--          requires = {
	--        	  "nvim-treesitter/nvim-treesitter",
	--          },
	--          config = function()
	--        	  require("treesitter-context.config").setup()
	--          end,
	--  })

	--   use({
	--     "nvim-treesitter/nvim-treesitter-textobjects",
	--     requires = { "nvim-treesitter/nvim-treesitter", },
	--   })

	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup({
				numhl = false,
				linehl = false,
				watch_gitdir = {
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

	-- use({
	--   "code-biscuits/nvim-biscuits",
	--   config = function()
	--     require("nvim-biscuits").setup({
	--       toggle_keybind = require("binds").biscuits_bind,
	--       default_config = {
	--         max_length = 12,
	--         min_distance = 5,
	--         prefix_string = " ⓘ ",
	--       },
	--       language_config = {
	--         html = {
	--           prefix_string = " 🌐 ",
	--         },
	--         javascript = {
	--           prefix_string = " ✨ ",
	--           max_length = 80,
	--         },
	--         python = {
	--           disabled = true,
	--         },
	--       },
	--     })
	--   end,
	-- })

	--completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"f3fora/cmp-spell",
			"honza/vim-snippets",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-cmdline",
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
		-- "github/copilot.vim",

		--git
		"tpope/vim-fugitive",
		-- "lewis6991/gitsigns.nvim",

		-- new movements
		-- "terrortylor/nvim-comment",
		"andymass/vim-matchup",

		"blackCauldron7/surround.nvim",

		--cosmetics
		-- "eddyekofo94/gruvbox-flat.nvim",
		"folke/twilight.nvim",
		"jubnzv/virtual-types.nvim",
		-- "morhetz/gruvbox",
		"nvim-lua/popup.nvim",
		"ray-x/lsp_signature.nvim",
		"theprimeagen/harpoon",
		-- "rrethy/vim-illuminate",
		"sainnhe/sonokai",
		"nekonako/xresources-nvim",
		"mhartington/oceanic-next",

		--information
		-- "folke/trouble.nvim",
		-- "simrat39/symbols-outline.nvim",
		"mbbill/undotree",
		"stevearc/aerial.nvim",

		-- "nathom/filetype.nvim",
		"skanehira/translate.vim",
		"wbthomason/packer.nvim",
	})
end)

-- use({
--   "glepnir/lspsaga.nvim",
--   config = function()
--     require("lspsaga").init_lsp_saga({ border_style = "none" })
--   end,
-- })

-- -- this plugin didnt work 12/6/21
-- use({
--   "stevearc/dressing.nvim",
--   config = function()
--     require("dressing").setup({
--       select = {
--         -- Options for built-in selector
--         builtin = {
--           -- These are passed to nvim_open_win
--           anchor = "NW",
--           relative = "cursor",
--           row = 0,
--           col = 0,
--           border = "none",
--           -- Window options
--           winblend = 10,
--           -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
--           width = nil,
--           max_width = 0.8,
--           min_width = 40,
--           height = nil,
--           max_height = 0.9,
--           min_height = 10,
--         },
--         -- see :help dressing_get_config
--         get_config = nil,
--       },
--     })
--   end,
-- })

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
