local lazyload = require("manager.lazyload")

return function(manager)
    manager.add({
        id = "vim-better-whitespace",
        url = "https://github.com/ntpeters/vim-better-whitespace",
    })

    lazyload.event("BufWinEnter", "vim-better-whitespace")
end
