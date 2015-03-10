
"colorscheme molokai
colorscheme distinguished
colorscheme vividchalk
highlight CursorLine cterm=bold ctermbg=Black

if &diff
  set diffopt+=iwhite
endif

if &bin
  au BufReadPost * %!xxd
  au BufWritePre * %!xxd -r
endif

set nocompatible

set wildmenu
set number
set list
set listchars=tab:↹∘,trail:∙
set matchpairs+=<:>
set cursorline
set colorcolumn=79

set hlsearch
set incsearch

set mouse=a

set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set scrolloff=9

set showmode

