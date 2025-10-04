local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim",
    config = function ()
        require("toggleterm").setup({
            open_mapping = [[<C-_>]],
            hide_numbers = true,
            close_on_exit = true,
            direction = "tab"
        })
    end
})
lazyload.event("VimEnter", "toggleterm.nvim")
