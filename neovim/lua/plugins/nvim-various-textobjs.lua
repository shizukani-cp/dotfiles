local lazyload = require("manager.lazyload")

local function config()
    require("various-textobjs").setup({
        keymaps = {
            useDefaults = true
        }
    })
end

return function(manager)
    manager.add({
        id = "nvim-various-textobjs",
        url = "https://github.com/chrisgrieser/nvim-various-textobjs",
        config = config,
    })
    lazyload.event("VimEnter", "nvim-various-textobjs")
end
