:set virtualedit=onemore
:set t_Co=256
:set t_AB=[48;5;%dm
:set t_AF=[38;5;%dm
:colorscheme Monokai-Refined
:syntax on
:set expandtab
:set tabstop=4
:set autoindent
:set smartindent
" The following sets up a very permissive backspace command, so that you can use backspace pretty much anywhere.
:set backspace=indent,eol,start
" The following 2 *map statements allow for 'inverse tabbing' using 'shift-tab'
" for insert mode
imap <S-Tab> <Esc><<i
" for command mode
nmap <S-Tab> <<
