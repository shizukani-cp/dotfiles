return function(manager)
    manager.add({
        id = "manager-lock",
        url = "https://github.com/shizukani-cp/manager-lock",
        dev = false,
        dir = vim.fn.expand("$PROJECTS_DIR") .. "/manager-lock",
    })
    manager.load("manager-lock")
end
