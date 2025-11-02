local lazyload = require("utils.lazyload")

local function config()
    require("hop").setup({
        keys = 'etovxqpdygfblzhckisuran'
    })
end

return function(manager)
    manager.add({
        id = "hop.nvim",
        url = "https://github.com/smoka7/hop.nvim",
        config = config
    })
    lazyload.key("n", "f", "<Cmd>HopWord<Cr>", "hop.nvim",
        { noremap = true, silent = true, desc = "Go to any word in the current buffer." })
end
