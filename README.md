## endwize.vim

This is a clone of endwise.vim. ( http://www.vim.org/scripts/script.php?script\_id=2386 )
This plugin supports `if end`-like syntax input.

### mapping

This plugin doesn't map any keys unlike an original one.
If you can use `imap`, mapping would be like below.

```
imap <silent><CR> <CR><Plug>DiscretionaryEnd
```

If `imap` is unavailable because of other features for `<CR>`,
mapping would be like below.

```
inoremap <silent><CR> <CR><C-r>=endwize#crend()<CR>
```

For example, when you want to use both `smart_close_popup()` of neocomplcache-snippets-complete,
mapping would be like below.

```
inoremap <silent><expr><CR> (pumvisible() ? neocomplcache#smart_close_popup() : "")."\<CR>\<C-r>=endwize#crend()\<CR>"
```
