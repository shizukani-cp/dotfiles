return function(manager)
    manager:add({
        id = "vim-illuminate",
        url = "https://github.com/RRethy/vim-illuminate",
    })
    manager:lazyload_event("BufRead", "vim-illuminate")
end
