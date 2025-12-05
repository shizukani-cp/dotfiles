local lazyload = require("manager.lazyload")

return function(manager)
    manager.add({
        id = "nvimdoc-ja",
        url = "https://github.com/vim-jp/nvimdoc-ja",
    })
    lazyload.event("BufWinEnter", "nvimdoc-ja")
end
