" packages
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif
packadd minpac
call minpac#init()
" call minpac#add('ericjuma/wal.vim')
" call minpac#add('nvim-lua/diagnostic-nvim')
call minpac#add('vim-pandoc/vim-pandoc-syntax')
" call minpac#add('kevinhwang91/rnvimr')
call minpac#add('Th3Whit3Wolf/spacebuddy')
call minpac#add('ericjuma/neowal')
call minpac#add('godlygeek/tabular')
call minpac#add('humanoid-colors/vim-humanoid-colorscheme')
call minpac#add('junegunn/goyo.vim')
call minpac#add('junegunn/limelight.vim')
call minpac#add('kana/vim-textobj-user') " required by vim-textobj-space
" call minpac#add('kovetskiy/sxhkd-vim')
call minpac#add('kyazdani42/nvim-web-devicons')
call minpac#add('liuchengxu/vista.vim')
call minpac#add('mattn/emmet-vim')
call minpac#add('mbbill/undotree')
call minpac#add('morhetz/gruvbox')
call minpac#add('neovim/nvim-lspconfig')
call minpac#add('nvim-lua/completion-nvim')
call minpac#add('nvim-lua/plenary.nvim')
call minpac#add('nvim-lua/popup.nvim')
call minpac#add('nvim-treesitter/nvim-treesitter')
call minpac#add('preservim/nerdtree')
call minpac#add('rhysd/clever-f.vim')
call minpac#add('ryanoasis/vim-devicons')
call minpac#add('saihoooooooo/vim-textobj-space')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('tjdevries/colorbuddy.nvim')
call minpac#add('tomtom/tcomment_vim')
call minpac#add('tpope/vim-markdown')
call minpac#add('tpope/vim-surround')
" for translating words from en to es
call minpac#add('skanehira/translate.vim')
packloadall
