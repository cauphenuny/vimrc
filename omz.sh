#!/usr/bin/env zsh

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

./zsh-plugin.sh

cp default.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/
