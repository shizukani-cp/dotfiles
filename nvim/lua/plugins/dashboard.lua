local function config(manager)
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
                    action = "ene | startinsert",
                },
                {
                    icon = "  ",
                    key = "e",
                    keymap_hl = "New Example Buffer",
                    desc = "New Example Buffer",
                    action = function()
                        require("utils.example_file").open_example()
                    end,
                },
                {
                    icon = "📁 ",
                    key = "f",
                    keymap_hl = "File",
                    desc = "File",
                    action = function()
                        manager:load("vist.nvim")
                        require("vist.core").open(require("vist.file"))
                    end,
                },
                {
                    icon = "🌀 ",
                    key = "g",
                    keymap_hl = "Lazygit",
                    desc = "Lazygit",
                    action = function()
                        manager:load("lazygit.nvim")
                        vim.cmd([[LazyGit]])
                    end,
                },
                {
                    icon = "🔄 ",
                    key = "u",
                    keymap_hl = "Update Plugins",
                    desc = "Update Plugins",
                    action = function()
                        manager:update()
                    end,
                },
                {
                    icon = "🗑️ ",
                    key = "c",
                    keymap_hl = "Clean Unused Plugins",
                    desc = "Clean Unused Plugins",
                    action = function()
                        manager:clean()
                    end,
                },
                {
                    icon = "  ",
                    icon_hl = "Quit",
                    desc = "Quit",
                    key = "q",
                    keymap_hl = "Quit",
                    key_format = " %s",
                    action = "quit",
                },
            },
        },
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "dashboard",
        callback = function()
            vim.cmd("DisableWhitespace")
        end,
    })
end

return function(manager)
    manager:add({
        id = "dashboard-nvim",
        url = "https://github.com/nvimdev/dashboard-nvim",
        dependencies = {
            "nvim-web-devicons",
            "vim-better-whitespace",
        },
        config = config,
    })
    manager:locked_load("dashboard-nvim")
end
