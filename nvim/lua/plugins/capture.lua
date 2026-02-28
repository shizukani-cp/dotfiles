return function(manager)
    manager:add({
        id = "capture.vim",
        url = "https://github.com/tyru/capture.vim",
    })
    manager:lazyload_event("CmdLineEnter", "capture.vim")
    manager:lazyload_key(
        "n",
        "<Leader>em",
        "<Cmd>Capture messages<Cr>",
        "capture.vim",
        { noremap = true, silent = true, desc = "Messages" }
    )
end
