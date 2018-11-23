#!/bin/bash

echo "Start install python =======================>"

git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv

echo "add env to bashrc"
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> $HOME/.bashrc

source ~/.bashrc

export PYTHON_CONFIGURE_OPTS="--enable-shared"
pyenv install 3.7.0
pyenv global 3.7.0


echo "Finish install python =======================>"