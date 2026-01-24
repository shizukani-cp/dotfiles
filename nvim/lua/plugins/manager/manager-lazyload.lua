return function(manager)
    manager.add({
        id = "manager-lazyload",
        url = "https://github.com/shizukani-cp/manager-lazyload",
        dev = false,
        dir = vim.fn.expand("$PROJECTS_DIR") .. "/manager-lazyload",
    })
    manager.load("manager-lazyload")
    -- vim.opt.runtimepath:prepend(vim.fn.expand("$HOME") .. "/programs/manager-lazyload")
end
