return function(manager)
    manager.add({
        id = "status-git",
        url = "https://github.com/shizukani-cp/status-git",
        dependencies = {
            "gitsigns.nvim",
        },
    })
end
