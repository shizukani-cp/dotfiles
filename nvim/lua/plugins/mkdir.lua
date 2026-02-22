local lock = require("manager.lock")

return function(manager)
    manager.add({
        id = "mkdir.nvim",
        url = "https://github.com/jghauser/mkdir.nvim",
    })
    lock.load("mkdir.nvim")
end
