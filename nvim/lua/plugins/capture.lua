return function(manager)
    manager:add({
        id = "capture.vim",
        url = "https://github.com/tyru/capture.vim",
    })
    manager:lazyload_event("CmdLineEnter", "capture.vim")
end
