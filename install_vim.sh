#!/bin/bash

echo "Start install vim plugins ==========>"
echo "[ -f /etc/bash_completion ] && \. /etc/bash_completion" >> ~/.bashrc
source /root/.bashrc

# 用vundle管理vim插件
echo "-->download vundle to manage vim plugins..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# 安装javascript语法检查
# 可以选择jshint或者eslint
npm install -g eslint
npm install -g typescript

# # 安装vim插件
echo "-->install vim plugins..."
vim -c PluginInstall -c q -c q
# cd /root/.vim/bundle/YouCompleteMe/ && /root/.pyenv/shims/python install.py --clang-completer --java-completer --go-completer

sed -i 's/"colorscheme solarized/colorscheme solarized/' ~/.vimrc
git clone https://github.com/powerline/fonts.git ~/fonts
~/fonts/install.sh
rm -rf ~/fonts

echo "End install vim plugins ==========>"