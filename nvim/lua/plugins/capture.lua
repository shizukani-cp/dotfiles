local lazyload = require("manager.lazyload")

return function(manager)
    manager.add({
        id = "capture.vim",
        url = "https://github.com/tyru/capture.vim",
    })
    lazyload.event("CmdLineEnter", "capture.vim")
    lazyload.key("n", "<Leader>em", "<Cmd>Capture messages<Cr>", "capture.vim",
        { noremap = true, silent = true, desc = "Messages" })
end
