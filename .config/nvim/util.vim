" goyo settings
" bound to leader z, removes extra ui elements and highlights only the selected
" paragraph
fun! s:goyo_enter()
    set noshowmode
    set noshowcmd
    Limelight
endfun

fun! s:goyo_leave()
    set showmode
    set showcmd
    Limelight!
endfun

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

fun! Mynum()
    set nu!
    set relativenumber!
endfun

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" fun! g:GoToMiddle(denotation)
"     if a:denotation == "ip"
"         execute "normal!wv" . a:denotation . "\"zy"
"     else
"         execute "normal!v" . a:denotation . "\"zy"
"     endif
"     let l:object = @z
"     let l:middle = strlen(l:object) / 2
"     execute "normal!" . l:middle . " "
" endfun


" augroups and autocmds for QOL
augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

" augroup oen_save
"     autocmd!
"     autocmd beufWritePr * :call TrimWhitespace()
" augroup END

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" autocommands for qol in markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd FileType markdown set conceallevel=2
autocmd FileType markdown setlocal spell spelllang=en_us
autocmd FileType markdown map <M-b> :call g:PandocSmartExport()<CR>
autocmd FileType markdown nmap <Leader>c :call g:PandocSmartExport()<CR>
" spanish translation
autocmd FileType markdown nmap gr <Plug>(Translate)
autocmd FileType markdown vmap T <Plug>(VTranslate)
autocmd FileType markdown nmap <leader>t :Translate! 
autocmd FileType markdown nmap <leader>T :Translate 
autocmd FileType text nmap <leader>t :Translate! 
autocmd FileType text nmap <leader>T :Translate 
" emmet makes writing html easier
autocmd FileType html,css EmmetInstall
