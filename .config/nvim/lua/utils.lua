function ToggleNums ()
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
