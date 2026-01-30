local lazyload = require("manager.lazyload")

return function(manager)
    manager.add({
        id = "nvim-syntax-info",
        url = "https://github.com/wadackel/nvim-syntax-info",
    })
    lazyload.key(
        "n",
        "<Leader>ci",
        "<Plug>(syntax-info-toggle)",
        "nvim-syntax-info",
        { noremap = true, silent = true, desc = "Syntax info" }
    )
end
