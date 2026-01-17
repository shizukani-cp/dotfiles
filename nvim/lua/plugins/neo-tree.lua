local function config()
    require("neo-tree").setup({
        sources = { "buffers" },
        default_source = "buffers",
        source_selector = {
            winbar = false,
        },
        buffers = {
            follow_current_file = { enabled = true },
            group_empty_dirs = true,
        },
        window = {
            position = "left",
            width = 30,
            fixed_width = true,
            mappings = {
                ["<space>"] = "none",
                ["bd"] = "buffer_delete",
            }
        },
        open_files_do_not_replace_types = { "terminal", "trouble", "qf", "edgy" },
    })
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            vim.schedule(function()
                vim.cmd("Neotree")
                vim.cmd("wincmd l")
            end)
        end,
    })
end

return function(manager)
    manager.add({
        id = "neo-tree.nvim",
        url = "https://github.com/nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "plenary.nvim",
            "nui.nvim",
            "nvim-web-devicons",
        },
        config = config,
    })
    manager.load("neo-tree.nvim")
end
