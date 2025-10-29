local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "f-string-toggle.nvim",
    url = "https://github.com/roobert/f-string-toggle.nvim",
    config = function()
        require("f-string-toggle").setup({
            key_binding = "<leader>F",
            key_binding_desc = "f-string",
            filetypes = { "python" },
        })
        vim.keymap.set("i", "<C-f>", function()
            require("f-string-toggle").toggle_fstring()
        end, { desc = "f-string" })
    end
})

lazyload.event("BufEnter", "f-string-toggle.nvim", { "*.py" })
