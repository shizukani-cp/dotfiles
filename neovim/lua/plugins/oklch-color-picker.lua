local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "oklch-color-picker.nvim",
    url = "https://github.com/eero-lehtinen/oklch-color-picker.nvim",
    config = function()
        require("oklch-color-picker").setup()
    end
})
lazyload.event("VimEnter", "oklch-color-picker.nvim")
lazyload.key("n", "<Leader>#", function() require("oklch-color-picker").pick_under_cursor() end,
    "oklch-color-picker.nvim", { noremap = true, silent = true, desc = "Color Picker" })
