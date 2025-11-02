local lazyload = require("utils.lazyload")

return function(manager)
    manager.add({
        id = "vimdoc-ja",
        url = "https://github.com/vim-jp/vimdoc-ja",
    })
    lazyload.event("VimEnter", "vimdoc-ja")
end
