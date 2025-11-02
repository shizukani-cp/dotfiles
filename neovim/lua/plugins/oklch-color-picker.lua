local lazyload = require("utils.lazyload")

local function config()
    require("oklch-color-picker").setup()
end

return function(manager)
    manager.add({
        id = "oklch-color-picker.nvim",
        url = "https://github.com/eero-lehtinen/oklch-color-picker.nvim",
        config = config,
    })
    lazyload.event("VimEnter", "oklch-color-picker.nvim")
    lazyload.key("n", "<Leader>c#", function() require("oklch-color-picker").pick_under_cursor() end,
        "oklch-color-picker.nvim", { noremap = true, silent = true, desc = "Color Picker" })
end
