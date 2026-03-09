local function config()
    vim.g.better_whitespace_filetypes_blacklist = {
        "dashboard",
        "toggleterm",
        "help",
    }
end

return function(manager)
    manager:add({
        id = "vim-better-whitespace",
        url = "https://github.com/ntpeters/vim-better-whitespace",
        config = config,
    })

    manager:lazyload_event("SafeState", "vim-better-whitespace")
end
