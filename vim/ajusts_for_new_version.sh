#!/bin/bash

#Script para fazer os links simbólicos que o Vim precisa.
## Versão atual = 
## $ brew list --version vim
## vim 9.1.2100

VIM_VERSION=$(brew list --versions vim | awk '{print $2}')
VIM_CELLAR="$HOMEBREW_PREFIX/Cellar/vim/$VIM_VERSION/share/vim/vim91"
VIM_SHARE="$HOMEBREW_PREFIX/share/vim"

mkdir -p "$VIM_SHARE/syntax"
ln -sf "$VIM_CELLAR/syntax/syntax.vim" "$VIM_SHARE/syntax/syntax.vim"
ln -sf "$VIM_CELLAR/colors" "$VIM_SHARE/colors"
ln -sf "$VIM_CELLAR/filetype.vim" "$VIM_SHARE/filetype.vim"
