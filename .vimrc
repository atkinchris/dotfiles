set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'easymotion/vim-easymotion'
Plugin 'flazz/vim-colorschemes'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'mxw/vim-jsx'
Plugin 'w0rp/ale'
Plugin 'miyakogi/seiya.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'

call vundle#end()
filetype plugin indent on

let g:Easymotion_do_mapping = 0
nmap <Space><Space> <Plug>(easymotion-jumptoanywhere)
map <silent> <C-n> :NERDTreeToggle<CR>
map <silent> <S-n> :GFiles<CR>

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
