local lazyload = require("utils.lazyload")

return function(manager)
    manager.add({
        id = "jumpcursor.vim",
        url = "https://github.com/skanehira/jumpcursor.vim",
    })
    lazyload.key("n", "f", "<Plug>(jumpcursor-jump)", "jumpcursor.vim",
        { noremap = true, silent = true, desc = "Go to any word in the current buffer." })
end
