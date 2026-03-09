return function(manager)
    manager:add({
        id = "nvimdoc-ja",
        url = "https://github.com/vim-jp/nvimdoc-ja",
    })
    manager:lazyload_event("SafeState", "nvimdoc-ja")
end
