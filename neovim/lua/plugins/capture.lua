local lazyload = require("utils.lazyload")

return function(manager)
    manager.add({
        id = "capture.vim",
        url = "https://github.com/tyru/capture.vim",
    })
    lazyload.event("VimEnter", "capture.vim")
end
