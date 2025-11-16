local lazyload = require("manager.lazyload")

return function(manager)
    manager.add({
        id = "vim-illuminate",
        url = "https://github.com/RRethy/vim-illuminate",
    })
    lazyload.event("VimEnter", "vim-illuminate")
end
