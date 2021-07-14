if not pcall(require, "telescope") then
  return
end

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local action_mt = require "telescope.actions.mt"
local sorters = require "telescope.sorters"
local themes = require "telescope.themes"
local set_prompt_to_entry_value = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == "table" then
    return
  end

  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

-- local action_set = require('telescope.actions.set')
local _ = pcall(require, "nvim-nonicons")

require("telescope").setup {
  defaults              = {
    prompt_prefix       = "❯ ",
    selection_caret     = "❯ ",

    winblend            = 0,

    layout_strategy     = "horizontal",
    layout_config       = {
      width             = 0.95,
      height            = 0.85,
      -- preview_cutoff = 120,
      prompt_position = "top",

      horizontal = {
        -- width_padding = 0.1,
        -- height_padding = 0.1,
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },

      vertical = {
        -- width_padding = 0.05,
        -- height_padding = 1,
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },

    selection_strategy = "reset",
    sorting_strategy = "descending",
    scroll_strategy = "cycle",
    color_devicons = true,

    mappings = {
      i = {
        ["ZQ"] = actions.close,
        ["ZZ"] = actions.send_to_qflist + actions.open_qflist + actions.close,
        ["<C-x>"] = false,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-y>"] = set_prompt_to_entry_value,

        -- Experimental
        -- ["<tab>"] = actions.toggle_selection,

        -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },

    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

    file_sorter = sorters.get_fzy_sorter,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  },

  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
  },
}

-- pcall(require("telescope").load_extension, "fzy-native")

local M = {}

function M.fd()
  require("telescope.builtin").fd()
end

function M.builtin()
  require("telescope.builtin").builtin()
end

function M.git_files()
  local path = vim.fn.expand "%:h"

  local width = 0.25

  local opts = themes.get_dropdown {
    winblend = 5,
    previewer = false,
    shorten_path = false,

    cwd = path,

    layout_config = {
      width = width,
    },
  }

  require("telescope.builtin").git_files(opts)
end

function M.buffer_git_files()
  require("telescope.builtin").git_files(themes.get_dropdown {
    cwd = vim.fn.expand "%:p:h",
    winblend = 10,
    border = true,
    previewer = true,
    shorten_path = false,
  })
end

function M.find_files()
  require('telescope.builtin').find_files(themes.get_dropdown {
    -- cwd = vim.fn.expand "~/",
    winblend = 5,
    border = true,
    previewer = false,
    shorten_path = false,
  })
end

function M.live_grep()
  require('telescope.builtin').live_grep(themes.get_dropdown {
    -- cwd = vim.fn.expand "~/",
    winblend = 5,
    border = true,
    previewer = false,
    shorten_path = false,
  })
end

function M.help_tags()
  require('telescope.builtin').help_tags(themes.get_dropdown {
    -- cwd = vim.fn.expand "~/",
    winblend = 5,
    border = true,
    previewer = false,
    shorten_path = false,
  })
end

function M.find_conf()
  require('telescope.builtin').find_files(themes.get_dropdown {
    prompt_title = '[ config ]',
    cwd = "~/.dotfiles",
    winblend = 5,
    border = true,
    previewer = false,
    shorten_path = false,
  })
end

function M.local_browse()
  require('telescope.builtin').file_browser(themes.get_ivy {
    prompt_title = '[ files ]',
    cwd = vim.fn.expand "%:p:h",
    winblend = 5,
    border = true,
    layout_config = {
      height = 0.3,
    },
  })
end

return M
