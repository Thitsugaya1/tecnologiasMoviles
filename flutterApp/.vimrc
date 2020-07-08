call plug#load('coc.nvim', 'syntastic')

set foldmethod=syntax

set statusline+=%#warningmsg#
set statusline+=%coc#status
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set nu

autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
autocmd BufNewFile,BufRead *.ts setlocal syntax=typescript

source ~/Templates/.vimrc-coc
