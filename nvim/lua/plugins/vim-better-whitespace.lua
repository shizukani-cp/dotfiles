return function(manager)
    manager:add({
        id = "vim-better-whitespace",
        url = "https://github.com/ntpeters/vim-better-whitespace",
    })

    manager:lazyload_event("BufWinEnter", "vim-better-whitespace")
end
