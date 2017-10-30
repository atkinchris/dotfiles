set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'flazz/vim-colorschemes'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'mileszs/ack.vim'
Plugin 'miyakogi/seiya.vim'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'townk/vim-autoclose'
Plugin 'vim-airline/vim-airline'
Plugin 'VundleVim/Vundle.vim'
Plugin 'w0rp/ale'
Plugin 'Xuyuanp/nerdtree-git-plugin'

call vundle#end()
filetype plugin indent on

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

let g:Easymotion_do_mapping = 0
nmap <Space><Space> <Plug>(easymotion-jumptoanywhere)
map <silent> <C-n> :NERDTreeToggle<CR>
map <silent> <S-n> :GFiles<CR>
map <C-a> <esc>ggVG<CR>

colorscheme monokai

let g:seiya_auto_enable=1

set backspace=2
set binary
set noeol
set number
set nocompatible
set clipboard=unnamed
set mouse=a
set nostartofline
set showmode
set scrolloff=3
set tabstop=4
set shiftwidth=2
set expandtab

syntax on