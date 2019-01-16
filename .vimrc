syntax on
set confirm


set number

set mouse=a

set tabstop=4
set shiftwidth=4
set smarttab
set autoindent " ai - включить автоотступы (копируется отступ предыдущей строки)
set cindent " ci - отступы в стиле С
set expandtab " преобразовать табуляцию в пробелы
set smartindent " Умные отступы 
set et

set wrap
set linebreak

set ai

set showmatch 
set hlsearch
set incsearch
set ignorecase

set listchars=tab:··
set list

set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866
set autoread

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [POS=%04l,%04v]\ [LEN=%L]


set clipboard=unnamed

set tags=tags\ $VIMRUNTIME/systags " искать теги в текущй директории и в указанной

if has('gui')
if has('win32')
au GUIEnter * call libcallnr('maximize', 'Maximize', 1)
elseif has('gui_gtk2')
au GUIEnter * :set lines=99999 columns=99999
endif
endif
