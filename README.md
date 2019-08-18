# fzf :heart: quickfix

![](https://user-images.githubusercontent.com/25827968/41820959-fa2049f6-77d9-11e8-900b-54922960c4a5.png)

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
nnoremap <Leader>l :Quickfix!<CR>

```

## Documentation

For more information, see `:help fzf_quickfix.txt`.

## License

MIT
