# fzf :heart: quickfix

![](https://user-images.githubusercontent.com/25827968/41820959-fa2049f6-77d9-11e8-900b-54922960c4a5.png)

## Installation
    ```vim
    Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
    Plug 'fszymanski/fzf-quickfix'

    " OR

    " Lazy loading
    Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
    Plug 'fszymanski/fzf-quickfix, {'on': '<Plug>(fzf-quickfix)'}

    nmap <Leader>q <Plug>(fzf-quickfix)
    ```
## Documentation

For more information, see `:help fzf_quickfix.txt`.

## License

MIT
