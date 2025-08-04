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
                header = {
                    "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
                    "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
                    "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
                    "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
                    "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
                    "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
                },
                center = {
                     {
                        icon = "  ",
                        key = "n",
                        keymap_hl = "New File",
                        desc = "New File",
                        action = "ene | startinsert"
                    },
                    {
                        icon = "📁 ",
                        key = "f",
                        keymap_hl = "Open Oil",
                        desc = "Open Oil",
                        action = [[lua require("utils.manager").load("oil.nvim"); vim.cmd("Oil")]]
                    },
                    {
                        icon = "🌀 ",
                        key = "g",
                        keymap_hl = "Show Lazygit",
                        desc = "Show Lazygit",
                        action = [[lua require("utils.manager").load("lazygit.nvim"); vim.cmd("LazyGit")]]
                    },
                    {
                        icon = "🔄 ",
                        key = "u",
                        keymap_hl = "Update Plugins",
                        desc = "Update Plugins",
                        action = [[lua require("utils.manager").update()]]
                    },
                    {
                        icon = "🗑️ ",
                        key = "c",
                        keymap_hl = "Clean Unused Plugins",
                        desc = "Clean Unused Plugins",
                        action = [[lua require("utils.manager").clean()]]
                    },
                    {
                        icon = "  ",
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
