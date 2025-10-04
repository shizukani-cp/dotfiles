local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "hop.nvim",
    url = "https://github.com/smoka7/hop.nvim",
    config = function ()
        require("hop").setup({
            keys = 'etovxqpdygfblzhckisuran'
        })
    end
})
lazyload.key("n", "f", "<Cmd>HopWord<Cr>", "hop.nvim", { noremap = true, silent = true, desc = "Go to any word in the current buffer." })
