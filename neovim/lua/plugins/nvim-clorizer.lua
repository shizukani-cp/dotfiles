local manager = require("utils.manager")

manager.add({
    id = "nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua",
    config = function ()
        require("colorizer").setup({
            css = {
                css = true,
                css_fn = true,
            },
            html = {
                css = true,
                css_fn = true,
            },
            javascript = {
                css = true,
                css_fn = true,
            }
        })
    end
})
manager.load("nvim-colorizer.lua")
