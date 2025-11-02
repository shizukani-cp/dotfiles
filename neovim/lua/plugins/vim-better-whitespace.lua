local lazyload = require("utils.lazyload")

return function(manager)
    manager.add({
        id = "vim-better-whitespace",
        url = "https://github.com/ntpeters/vim-better-whitespace",
    })

    lazyload.event("VimEnter", "vim-better-whitespace")
end
