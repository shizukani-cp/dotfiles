return function(manager)
    manager:add({
        id = "nvimdoc-ja",
        url = "https://github.com/vim-jp/nvimdoc-ja",
    })
    manager:lazyload_event("BufWinEnter", "nvimdoc-ja")
end
