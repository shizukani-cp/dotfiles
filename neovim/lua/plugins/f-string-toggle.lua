local lazyload = require("utils.lazyload")

local function config()
    require("f-string-toggle").setup({
        key_binding = "<leader>F",
        key_binding_desc = "f-string",
        filetypes = { "python" },
    })
    vim.keymap.set("i", "<C-f>", function()
        require("f-string-toggle").toggle_fstring()
    end, { desc = "f-string" })
end

return function(manager)
    manager.add({
        id = "f-string-toggle.nvim",
        url = "https://github.com/roobert/f-string-toggle.nvim",
        config = config,
    })

    lazyload.event("BufEnter", "f-string-toggle.nvim", { "*.py" })
end
