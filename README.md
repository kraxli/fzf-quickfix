# fzf :heart: quickfix

![](https://user-images.githubusercontent.com/25827968/63228948-0d8ff100-c1fb-11e9-95d8-e5df195ba18e.png)

## Requirements
- [fzf](https://github.com/junegunn/fzf)

## Installation

Using the (Neo)vim built-in (kind of) plugin manager:

```sh
$ cd path/to/pack/foo/start
$ git clone https://github.com/fszymanski/fzf-quickfix.git
```

Using your favorite (Neo)vim plugin manager:

```vim
Plug 'fszymanski/fzf-quickfix', {'on': 'Quickfix'}

nnoremap <Leader>q :Quickfix<CR>
nnoremap <Leader>l :LocList<CR>
```

You can customize the options passed to `fzf_quickfix#run(...)` by passing a dictionary to the function. E.g:
```vim
 nnoremap <silent><localleader>q :call fzf_quickfix#run('','0', {'options': ['--layout=reverse', '--info=inline', '--preview-window', 'right:60%'], 'window': {'height': 0.5,  'width': 0.6 }}, 0)<cr>
```

in this way you can redefine the default `Quickfix` commands.

For full screen quickfix or location list use a bang (`!`), e.g. `:Quickfix!`



## Documentation

For more information, see `:help fzf_quickfix.txt`.

## License

MIT
