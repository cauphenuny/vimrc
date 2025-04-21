#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <init|link|copy> <vim|nvim|zsh>"
    exit 1
fi

ACTION="$1"
TARGET="$2"

mkdir -p "$HOME/.config"

case "$ACTION" in
init)
    case "$TARGET" in
    all)
        apt install git zsh vim
        ;;
    nvim)
        apt install nvim
        ;;
    esac
    ;;
link)
    case "$TARGET" in
    vim)
        git submodule update --init --recursive
        ln -s "$(pwd)/vim" "$HOME/.vim"
        ;;
    nvim)
        ln -s "$(pwd)/nvim" "$HOME/.config/nvim"
        ;;
    zsh)
        ln -s "$(pwd)/zsh" "$HOME/.config/zsh"
        assets/omz.sh
        ;;
    *)
        echo "Invalid target: $TARGET"
        exit 1
        ;;
    esac
    ;;
copy)
    case "$TARGET" in
    vim)
        git submodule update --init --recursive
        cp -r "$(pwd)/vim" "$HOME/.vim"
        ;;
    nvim)
        cp -r "$(pwd)/nvim" "$HOME/.config/nvim"
        ;;
    zsh)
        cp -r "$(pwd)/zsh" "$HOME/.config/zsh"
        assets/omz.sh
        ;;
    *)
        echo "Invalid target: $TARGET"
        exit 1
        ;;
    esac
    ;;
*)
    echo "Invalid action: $ACTION"
    exit 1
    ;;
esac
