local cmd = vim.cmd

local function define_augroups(definitions) -- {{{
  -- Create autocommand groups based on the passed definitions
  --
  -- The key will be the name of the group, and each definition
  -- within the group should have:
  --    1. Trigger
  --    2. Pattern
  --    3. Text
  -- just like how they would normally be defined from Vim itself
  for group_name, definition in pairs(definitions) do
    cmd("augroup " .. group_name)
    cmd("autocmd!")

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
      cmd(command)
    end

    cmd("augroup END")
  end
end

cmd([[
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
augroup trim_on_save
    autocmd! * <buffer>
    autocmd BufWritePre <buffer> call TrimWhitespace()
augroup END
]])

-- {'', '', [[]]},
define_augroups({
  general_settings = {
    { "TextYankPost", "*", [[lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})]] },
    { "BufWinEnter", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
    { "BufRead", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
    { "BufNewFile", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
    -- {'VimLeavePre', '*', 'set title set titleold='},
    -- {'User', 'GoyoEnter', 'nested call <SID>goyo_enter'},
    -- {'User', 'GoyoLeave', 'nested call <SID>goyo_leave'},
    { "BufNewFile,BufRead", "*.md", "set filetype=markdown" },
    { "StdinReadPre", "*", "let s:std_in=1" },
    -- {'VimEnter', '*', [[if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif]]},
    -- {'VimEnter', '*', [[highlight SignColumn ctermbg=NONE guibg=NONE]]},
    -- {'ColorScheme', '*', [[highlight VertSplit ctermbg=none guibg=NONE]]},
    { "VimEnter", "*", [[Gitsigns toggle_signs]] },
    -- {'Filetype', 'html,css', 'EmmetInstall'},
    { "CursorMoved", "*", "if (expand('<cword>') =~ @/) | set hlsearch | else | set nohlsearch | endif" },
    -- { "User", "DiagnosticsChanged", "lua vim.diagnostic.setqflist({open = false })" }, -- this would be for if i used qflist more
  },
  markdown = {
    -- {'FileType', 'markdown', 'set conceallevel=2'},
    -- {'FileType', 'markdown', 'setlocal spell spelllang=en_us'},
    -- {'FileType', 'markdown', 'set noexpandtab cindent preserveindent softtabstop=0 shiftwidth=2 tabstop=2'},
    { "FileType", "go", "set noexpandtab cindent preserveindent softtabstop=8 shiftwidth=8 tabstop=8" },
    { "FileType", "markdown", "map <M-b> :call g:PandocSmartExport()<CR>" },
    { "FileType", "markdown", "nmap <Leader>c :call g:PandocSmartExport()<CR>" },
    { "FileType", "markdown,text", "nmap gr <Plug>(Translate)" },
    { "FileType", "markdown,text", "vmap T <Plug>(VTranslate)" },
    { "BufWritePost", "*.js,*.lua,*.py", "FormatWrite" },
  },
  lua = {
    { "FileType", "lua", "set noexpandtab cindent preserveindent softtabstop=0 shiftwidth=2 tabstop=2" },
  },
  -- augroup vimrc     " Source vim configuration upon save
  --     autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
  --     autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  -- augroup END
})
