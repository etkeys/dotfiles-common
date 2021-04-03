" Based on Luke Smith's settings. LukeSmith.xyz
" Then adapted by me

let mapleader = " "

" the basics
    set background=dark
    set backupdir=~/.vim-tmp,~/tmp,/tmp
    set directory=~/.vim-tmp,~/tmp,/tmp
    set encoding=utf-8
    set number relativenumber
    set laststatus=2
    set scrolloff=5
    
    syntax on

    silent! source ~/.vimrc.asi
    
    execute pathogen#infect()

" Enable autocompletion
    set wildmode=longest,list,full

" Disable automatic commenting on newline
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Tab/Indent settings
    filetype plugin indent on
    set tabstop=4 shiftwidth=4 softtabstop=0 expandtab smarttab
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

" Syntastic settings
    let g:syntastic_python_checkers = ['pylint', 'python']
    

" ####################################
"    KEYBINDINGS
" ####################################

    map <C-v> "+P

" Remove bad habbit movement keys
    noremap <Left> <nop>
    noremap <Right> <nop>
    noremap <Up> <nop>
    noremap <Down> <nop>
    noremap <PageUp> <nop>
    noremap <PageDown> <nop>
 
" Insert mode bindings
    inoremap jj <Esc>
    inoremap yy <Esc>

" Normal mod bindings
    nnoremap <leader>; A<Enter><Esc>
    nnoremap <leader>U VxkP
    nnoremap <leader>u VyP
    nnoremap <leader>D Vxp
    nnoremap <leader>d Vyp
    nnoremap <leader>gh :tabp
    nnoremap <leader>gl :tabn
    nnoremap d "_d

    nnoremap <F4> :tabnew<CR>
    nnoremap <S-tab> :tabp<CR>
    nnoremap <tab> :tabn<CR>
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    nnoremap <F7> :NERDTreeToggle<CR>

    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>


" Visual mode bindings
    vnoremap <C-e> 3<C-e>
    vnoremap <C-y> 3<C-y>
    vnoremap d "_d
    vnoremap <C-c> "*y :let @+=@*<CR>

" ####################################
"    PLUGIN CONFIGS
" ####################################

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
