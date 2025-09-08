local manager = require("utils.manager")

manager.add({
    id = "denippet.vim",
    url = "https://github.com/uga-rosa/denippet.vim",
    dependencies = {
        "denops.vim",
    },
    config = function ()
        local dir = vim.fn.stdpath("config") .. "/snippets/"

        -- vim.fn["denippet#load"](dir .. "lua.toml")

        for _, file in ipairs(vim.fn.glob(dir .. "*.*", 1, 1)) do
            vim.fn["denippet#load"](file)
        end 

        vim.keymap.set("i", "<C-l>", "<Plug>(denippet-expand)")

        vim.keymap.set({ "i", "s" }, "<Tab>", function()
            return vim.fn["denippet#jumpable"]() and "<Plug>(denippet-jump-next)" or "<Tab>"
        end, { expr = true })

        vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
            return vim.fn["denippet#jumpable"](-1) and "<Plug>(denippet-jump-prev)" or "<S-Tab>"
        end, { expr = true })
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("denippet.vim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("denippet.vim")
    end
})
