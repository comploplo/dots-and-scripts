local cmd = vim.cmd
-- local g = vim.g
require('lspkind').init()
require('which-key').setup { }
require('lspsaga').init_lsp_saga()

-- This makes dirvish replace netrw
cmd([[
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
]])

-- require('colorbuddy').colorscheme('neowal')
-- cmd[[colorscheme neowal]]
cmd[[colorscheme gruvbox]]

require('nvim-treesitter.configs').setup {
	highlight = { enable = true, },
	indent = { enable = true, },
}

require('telescope').setup {
	extensions = { fzy_native = {
			override_generig_sortor = false,
			override_file_sorter = true,
	  }
	}
}


function _G.ToggleNums ()
  vim.cmd([[set number! relativenumber!]])
end

vim.cmd([[
fun! g:PandocSmartExport()
  if expand('%:e') == 'md'
    write
    if 'Ling' =~ expand('%:p:h:t')
        let l:pandoccall = 'pandoc ' . expand('%') . ' -o ' . expand('%:p:h') . '/' . expand('%:t:r') . '.pdf --template homework-ling.tex'
    else 
        let l:pandoccall = 'pandoc ' . expand('%') . ' -o ' . expand('%:p:h') . '/' . expand('%:t:r') . '.pdf --template homework.tex --pdf-engine xelatex'
    endif
    echo l:pandoccall
    echo system(l:pandoccall)
  else
    echo 'invalid file type'
  endif
endfun
]])
