return function(manager)
    manager:add({
        id = "jumpcursor.vim",
        url = "https://github.com/skanehira/jumpcursor.vim",
    })
    manager:lazyload_key(
        "n",
        "s",
        "<Plug>(jumpcursor-jump)",
        "jumpcursor.vim",
        { noremap = true, silent = true, desc = "Go to any word in the current buffer." }
    )
end
