# vimrc
my vim configuration

---

## usage

```shell
git clone https://github.com/hydropek/vimrc $HOME/.vim/
```

add these to `~/.vimrc`: 

```vim
let g:vim_conf_dir = $HOME . '/.vim/'
exec 'source ' . g:vim_conf_dir . "/vimrc"
```
