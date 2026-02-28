return function(manager)
    manager:add({
        id = "vimdoc-ja",
        url = "https://github.com/vim-jp/vimdoc-ja",
    })
    manager:lazyload_event("CmdLineEnter", "vimdoc-ja")
end
