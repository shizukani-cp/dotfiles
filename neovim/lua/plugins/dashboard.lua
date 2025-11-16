local function config()
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
                    icon = "  ",
                    key = "e",
                    keymap_hl = "New Example Buffer",
                    desc = "New Example Buffer",
                    action = function()
                        require("utils.example_file").open_example()
                    end
                },
                {
                    icon = "📁 ",
                    key = "f",
                    keymap_hl = "Oil",
                    desc = "Oil",
                    action = function()
                        require("manager.core").load("oil.nvim")
                        vim.cmd [[Oil]]
                    end
                },
                {
                    icon = "🌀 ",
                    key = "g",
                    keymap_hl = "Lazygit",
                    desc = "Lazygit",
                    action = function()
                        require("manager.core").load("lazygit.nvim")
                        vim.cmd [[LazyGit]]
                    end
                },
                {
                    icon = "🔄 ",
                    key = "u",
                    keymap_hl = "Update Plugins",
                    desc = "Update Plugins",
                    action = function()
                        require("manager.core").update()
                    end
                },
                {
                    icon = "🗑️ ",
                    key = "c",
                    keymap_hl = "Clean Unused Plugins",
                    desc = "Clean Unused Plugins",
                    action = function()
                        require("manager.core").clean()
                    end
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
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "dashboard",
        callback = function()
            vim.cmd("DisableWhitespace")
        end,
    })
    vim.api.nvim_create_autocmd({ "BufLeave", "BufUnload" }, {
        pattern = "*",
        callback = function()
            if vim.bo.filetype ~= "dashboard" then
                vim.cmd("EnableWhitespace")
            end
        end,
    })
end

return function(manager)
    manager.add({
        id = "dashboard-nvim",
        url = "https://github.com/nvimdev/dashboard-nvim",
        dependencies = {
            "nvim-web-devicons",
        },
        config = config
    })
    manager.load("dashboard-nvim")
end
