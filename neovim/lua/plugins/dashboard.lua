local manager = require("utils.manager")

manager.add({
    id = "dashboard-nvim",
    url = "https://github.com/nvimdev/dashboard-nvim",
    dependencies = {
        "nvim-web-devicons",
    },
    config = function ()
        require("dashboard").setup({
            theme = "doom",
            config = {
                center = {
                     {
                        icon = " ",
                        key = "n",
                        keymap_hl = "New File",
                        desc = "New File",
                        action = ":ene | startinsert"
                    },
                    {
                        icon = "",
                        icon_hl = "Quit",
                        desc = "Quit",
                        key = "q",
                        keymap_hl = "Quit",
                        key_format = " %s",
                        action = "quit"
                    },
                }
            }
        })
    end
})
manager.load("dashboard-nvim")
