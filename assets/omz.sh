#!/usr/bin/env zsh

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

assets/zsh-plugin.sh

cp assets/default.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/
